//
//  PosCommunication.m
//  QuanYiPos
//
//  Created by user on 13-3-28.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import "PosCommunication.h"
#define IPADDRESS @"172.16.10.71" //IP
#define PORT @"6000" //PORT

@implementation PosCommunication
@synthesize _accessory;
@synthesize session;
static PosCommunication *sharedInstance = nil;
BOOL isconnect;

+(PosCommunication *)sharedInstanceMethod
{
    @synchronized(self)
    {
        if(sharedInstance == nil)
        {
            isconnect = false;

            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}



- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
	switch(streamEvent)
	{
		case NSStreamEventOpenCompleted:
            NSLog(@"streams open complete");
            break;
		case NSStreamEventHasBytesAvailable:
            NSLog(@"NSStreamEventHasBytesAvailable");
            [self readData];
			break;
		case NSStreamEventHasSpaceAvailable:
			NSLog(@"application can sending data to accessory===>");
            break;
		case NSStreamEventErrorOccurred:
            NSLog(@"NSStreamEventErrorOccurred");
			break;
		default:
			break;
	}
}

- (NSString *)getHexString:(void *)buffer start:(int)startIndex end:(int)endIndex {
    NSString *bufferStr = @"";
    Byte *buf = (Byte *)buffer;
    for(int i = startIndex; i < endIndex; i ++) {
        bufferStr = [bufferStr stringByAppendingFormat:@"%02X ",  buf[i]];
    }
    return bufferStr;
}

-(void)sendMsg : (NSString *) message : (NSString *) content{
    NSDictionary *d = [NSDictionary dictionaryWithObject:content
                                                  forKey:message];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:message object:self userInfo:d];
}


-(void)readData
{
    NSLog(@"read data from pos...");
    //  [self showProgressBAR:@"正在接收POS数据..."];
    uint8_t buf[1024];
    unsigned int len = 0;
    //get receive data length
    
   
    len = [self.session.inputStream read:buf maxLength:2048];
    NSLog(@"Get Response===%@",[self getHexString:buf start:0 end:len]);
    
    if(len > 0){
        if(buf[0] != 0x55 || buf[1] != 0x66 || buf[2] != 0x77 || buf[3] != 0x88){
            NSLog(@"Get data error");
            return;
        }
        
        if(buf[4] != TAG_START)
        {
            NSLog(@"Tag header error");
        }
        
        //check crc
        Byte *resultvalue = (Byte*)malloc(len - 4- 2);
        Byte *crcvalue = (Byte*)malloc(2);
        
        memcpy(resultvalue, buf + 4, len - 4 - 2);
        memcpy(crcvalue,buf + len - 2,2);
        NSLog(@"Content===%@",[self getHexString:resultvalue start:0 end:len - 4 - 2]);
        NSLog(@"CRC = %@",[self getHexString:crcvalue start:0 end:2]);
        
        NSData *tlvdata = [[NSData alloc]initWithBytes:resultvalue length:len - 4 -2];
        NSLog(@"tlvdata src value = %@",[self getHexString:(Byte *)tlvdata.bytes start:0 end:tlvdata.length]);
        NSData *crcdata = [QuanYiPos calCRC:tlvdata];
        NSLog(@"CRC RESULT = %@",[self getHexString:(Byte *)crcdata.bytes start:0 end:crcdata.length]);
        
        NSString *crc1_value = [self getHexString:crcvalue start:0 end:2];
        NSString *crc2_value = [self getHexString:(Byte *)crcdata.bytes start:0 end:crcdata.length];
        
        if([crc1_value isEqualToString:crc2_value]){//crc 校验成功
            NSLog(@"CRC CHECK SUCCESS!");
            //解包
            int packagelength = 0;//包的总长度

            int offset = 4;//跳过IOS 的头
            offset += 1;//跳过桢头 0x03
            Byte *plbyte = (Byte*) malloc(2);//2字节长度
            memcpy(plbyte, buf + offset, 2);
            NSLog(@"package lenght = %@",[self getHexString:plbyte start:0 end:2]);

            offset += 2;//跳长度，2字节
            packagelength =  ByteArrayToInt(plbyte,2);
            NSLog(@"package length %d",packagelength);
       
            NSMutableString *sbuffer = [[NSMutableString alloc] init];
            //解包
            do{
                
                Byte* tag = (Byte*)malloc(1);//tag
                memcpy(tag, buf + offset, 1);
                offset +=1;
                NSString *tagString = [self getHexString: tag start:0 end:1];

                NSLog(@"TAG Name = %@",tagString);

                Byte* taglength = (Byte*)malloc(2);//length
                memcpy(taglength, buf + offset, 2);
                int tlength =  ByteArrayToInt(taglength,2);
                NSLog(@"TAG Length = %d",tlength);
                offset += 2;

                Byte* tagvalue = (Byte*)malloc(tlength);//value
                memcpy(tagvalue, buf+offset, tlength);
                NSLog(@"TAG Value = %@",[self getHexString:tagvalue start:0 end:tlength]);
                offset += tlength;
                
                NSString *tagValue = [self getHexString:tagvalue start:0 end:tlength];
                [sbuffer appendFormat:@"Tag=====>%@\n",tagString];
                [sbuffer appendFormat:@"Length==>%d\n",tlength];
                [sbuffer appendFormat:@"Value===>%@\n",tagValue];
                
                
                //ISO 8583
                NSLog(@"tagString %@",tagString);
                if([tagString hasPrefix:@"14"])//8583 tag
                {
                    //获取ISO 8583的包
                    //发送到服务器
                    package8583length = tlength;
                    NSLog(@"Get 8583 package , length = %d",package8583length);
                    [self sendSocketMessageToServer:tagvalue];
                }
                
                
            }while (offset < packagelength);
            [self sendMsg:@"MESSAGE_LOG" :sbuffer];
            sbuffer = nil;
        }else{
            //
            NSLog(@"CRC CHECK FAILED!");
        }
    }
}

//BYTE 转 INT
int ByteArrayToInt(Byte* buf,int bufLen)
{
	int i;
	int temp;
	temp=0;
	for(i=0;i<bufLen;i++)
	{
		temp=(temp<<8)+buf[i];
	}
	return temp;
}

//检察附件
-(Boolean) checkP200Device{
    NSArray *list=[[EAAccessoryManager sharedAccessoryManager] connectedAccessories];
    if(list != nil && [list count] > 0){
        for(int i = 0; i < [list count]; i ++){
            EAAccessory* accessory=[list objectAtIndex:i];
            if(accessory != nil && [accessory.name length] > 0){
                return YES;
                break;
            }else{
                return NO;
            }
        }
    }else{
        return NO;
    }
    return NO;
}

-(Boolean) connectToDevice : (NSString *)protocalstring{
    if([self checkP200Device] == YES){
        if(protocalstring != nil && [protocalstring length] > 0 ){
            NSArray *list=[[EAAccessoryManager sharedAccessoryManager] connectedAccessories];
            EAAccessory* accessory=[list objectAtIndex:0];
            self._accessory = accessory;
            self.session =  [[EASession alloc] initWithAccessory:accessory forProtocol:protocalstring];//
            [[session inputStream] setDelegate:self];
            [[session inputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [[session inputStream] open];
            [[session outputStream] setDelegate:self];
            [[session outputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [[session outputStream] open];
            return YES;
        }else{
            return NO;
        }
        return YES;
    }else{
        return NO;
    }
}

//SOCKET CONNECTION=========

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"didConnectToHost");
    [[SocketConnection sharedSingleton].client readDataWithTimeout:-1 tag:0];
}


//断开连接
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"onSocketDidDisconnect");

    //NSString *msg = @"Sorry this connect is failure";
    //   [self showMessage:msg];
    // NSLog(msg);
    [[SocketConnection sharedSingleton].client disconnect];
    
    [SocketConnection sharedSingleton].client  = nil;
    isconnect = false;
    result = 0;
}

- (void)onSocketDidSecure:(AsyncSocket *)sock{
	
    NSLog(@"onSocketDidSecure");

}


- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError");

    [[SocketConnection sharedSingleton].client disconnect];
    [SocketConnection sharedSingleton].client  = nil;
    isconnect = false;
    result = 0;
}

//socket 读SERVER响应数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"get socket data...");
    if(data != nil && data.length > 0)
    {
        NSUInteger len = [data length];
        Byte *byteData = (Byte*)malloc(len);
        memcpy(byteData, [data bytes], len);
        NSLog(@"GET SERVER RESPONSE====>%@", [QuanYiPos getHexString:byteData start:0 end:len]);
    }
    [[SocketConnection sharedSingleton].client readDataWithTimeout:25 tag:0];
}

-(void) sendSocketMessageToServer : ( Byte *)sendtoserverdata{
    NSString *ipaddress = IPADDRESS;
    NSString *portnumber = PORT;
    int port =  [portnumber intValue];
    // NSLog(ipaddress);
    
    if(isconnect == false){
        result = [[SocketConnection sharedSingleton] connectServer:ipaddress port:port :self];
    }
    if(result == 1){
        isconnect = true;
        //发送数据
        NSData *sendtoserver = [[NSData alloc] initWithBytes:sendtoserverdata length:package8583length];
         [[SocketConnection sharedSingleton].client writeData:sendtoserver withTimeout:30 tag:0];
        NSLog(@"SEND to Server @@@@====>%@", [self getHexString:sendtoserverdata start:0 end:package8583length]);
    }
    
}


@end
