//
//  QuanYiPos.m
//  QuanYiPos
//
//  Created by user on 13-4-1.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import "QuanYiPos.h"

@implementation QuanYiPos

static unsigned short ccitt_table[256] = {
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50A5, 0x60C6, 0x70E7,
    0x8108, 0x9129, 0xA14A, 0xB16B, 0xC18C, 0xD1AD, 0xE1CE, 0xF1EF,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52B5, 0x4294, 0x72F7, 0x62D6,
    0x9339, 0x8318, 0xB37B, 0xA35A, 0xD3BD, 0xC39C, 0xF3FF, 0xE3DE,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64E6, 0x74C7, 0x44A4, 0x5485,
    0xA56A, 0xB54B, 0x8528, 0x9509, 0xE5EE, 0xF5CF, 0xC5AC, 0xD58D,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76D7, 0x66F6, 0x5695, 0x46B4,
    0xB75B, 0xA77A, 0x9719, 0x8738, 0xF7DF, 0xE7FE, 0xD79D, 0xC7BC,
    0x48C4, 0x58E5, 0x6886, 0x78A7, 0x0840, 0x1861, 0x2802, 0x3823,
    0xC9CC, 0xD9ED, 0xE98E, 0xF9AF, 0x8948, 0x9969, 0xA90A, 0xB92B,
    0x5AF5, 0x4AD4, 0x7AB7, 0x6A96, 0x1A71, 0x0A50, 0x3A33, 0x2A12,
    0xDBFD, 0xCBDC, 0xFBBF, 0xEB9E, 0x9B79, 0x8B58, 0xBB3B, 0xAB1A,
    0x6CA6, 0x7C87, 0x4CE4, 0x5CC5, 0x2C22, 0x3C03, 0x0C60, 0x1C41,
    0xEDAE, 0xFD8F, 0xCDEC, 0xDDCD, 0xAD2A, 0xBD0B, 0x8D68, 0x9D49,
    0x7E97, 0x6EB6, 0x5ED5, 0x4EF4, 0x3E13, 0x2E32, 0x1E51, 0x0E70,
    0xFF9F, 0xEFBE, 0xDFDD, 0xCFFC, 0xBF1B, 0xAF3A, 0x9F59, 0x8F78,
    0x9188, 0x81A9, 0xB1CA, 0xA1EB, 0xD10C, 0xC12D, 0xF14E, 0xE16F,
    0x1080, 0x00A1, 0x30C2, 0x20E3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83B9, 0x9398, 0xA3FB, 0xB3DA, 0xC33D, 0xD31C, 0xE37F, 0xF35E,
    0x02B1, 0x1290, 0x22F3, 0x32D2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xB5EA, 0xA5CB, 0x95A8, 0x8589, 0xF56E, 0xE54F, 0xD52C, 0xC50D,
    0x34E2, 0x24C3, 0x14A0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xA7DB, 0xB7FA, 0x8799, 0x97B8, 0xE75F, 0xF77E, 0xC71D, 0xD73C,
    0x26D3, 0x36F2, 0x0691, 0x16B0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xD94C, 0xC96D, 0xF90E, 0xE92F, 0x99C8, 0x89E9, 0xB98A, 0xA9AB,
    0x5844, 0x4865, 0x7806, 0x6827, 0x18C0, 0x08E1, 0x3882, 0x28A3,
    0xCB7D, 0xDB5C, 0xEB3F, 0xFB1E, 0x8BF9, 0x9BD8, 0xABBB, 0xBB9A,
    0x4A75, 0x5A54, 0x6A37, 0x7A16, 0x0AF1, 0x1AD0, 0x2AB3, 0x3A92,
    0xFD2E, 0xED0F, 0xDD6C, 0xCD4D, 0xBDAA, 0xAD8B, 0x9DE8, 0x8DC9,
    0x7C26, 0x6C07, 0x5C64, 0x4C45, 0x3CA2, 0x2C83, 0x1CE0, 0x0CC1,
    0xEF1F, 0xFF3E, 0xCF5D, 0xDF7C, 0xAF9B, 0xBFBA, 0x8FD9, 0x9FF8,
    0x6E17, 0x7E36, 0x4E55, 0x5E74, 0x2E93, 0x3EB2, 0x0ED1, 0x1EF0
};


//打印LOG
+ (NSString *)getHexString:(void *)buffer start:(int)startIndex end:(int)endIndex {
    NSString *bufferStr = @"";
    Byte *buf = (Byte *)buffer;
    for(int i = startIndex; i < endIndex; i ++) {
        bufferStr= [bufferStr stringByAppendingFormat:@"%02X ",  buf[i]];
    }
    return bufferStr;
}

//组小的TLV包
+(NSData *) setTLV: (Byte) Tag : (Byte *)value : (int)length;
{
     if(length > 0)
    {
        Byte *lengthbyte = [self intToByte2:length];
        Byte *resultvalue = (Byte*)malloc(1 + 2 + length);
        memcpy(resultvalue, &Tag, 1);//set tag
        memcpy(resultvalue + 1, lengthbyte, 2);//set length
        memcpy(resultvalue + 1 + 2,value,length);//set value
        NSData *resultdata = [[NSData alloc] initWithBytes:resultvalue length:1 + 2 + length];
        return resultdata;
     }else{
        return nil;
     }
}

//组大的TLV包
+(NSData*) setTotalTLV:  (NSMutableArray *)parameters;
{
     int totalength = 0;
     Byte iosheader[] = {0x55,0x66,0x77,0x88};//ios 的通讯头
     if(parameters != nil && [parameters count] > 0)
    {
        for(int i = 0; i < [parameters count]; i ++)
        {
            NSData *bm = [parameters objectAtIndex:i];
            int length = bm.length;
            totalength += length;
        }
        int packagelength = 1/*Header 头*/ + 2/*Length 2字节长度*/ + totalength/*Content Length 内容长度*/ + 2/*CRC CRC校验*/;
        Byte *resultvalue = (Byte*)malloc(packagelength);
        Byte *lengthbyte = [self intToByte2:totalength];
        int offset = 0;
        memcpy(resultvalue, &TAG_START, 1);//set header
        offset += 1;
        memcpy(resultvalue + offset, lengthbyte, 2);//set length
        offset += 2;
        
        for(int i = 0; i < [parameters count]; i ++)
        {
            NSData *bm = [parameters objectAtIndex:i];
            int length = bm.length;
            Byte* content = (Byte *)bm.bytes;
            memcpy(resultvalue + offset, content, length);//set length
            offset += length;
        }
        //set CRC CRC校验码生成
        Byte* crcsourcedata = (Byte*)malloc(packagelength - 2);
        memcpy(crcsourcedata, resultvalue, packagelength - 2);
        NSData *crcsrc = [[NSData alloc]initWithBytes:crcsourcedata length:packagelength - 2];
        NSData *crcdata = [self calCRC:crcsrc];
        memcpy(resultvalue + offset, crcdata.bytes, 2);//set crc
        //set CRC END
        
        //set up ios header 55 66 77 88 4bytes
        
        Byte *resultvalueios = (Byte*)malloc(4  + packagelength);
        memcpy(resultvalueios, iosheader, 4);
        memcpy(resultvalueios + 4, resultvalue, packagelength);
//
        
        NSData *resultdata = [[NSData alloc] initWithBytes:resultvalueios length:4 + packagelength];
        return resultdata;
    }else {
        return nil;
    }
}



//int转byte2
+(Byte*) intToByte2:(int) number
{
    int tmp_num = number;
    Byte *byte2 = (Byte*)malloc(2);
    for (int i = 2 - 1; i > -1; i--)
    {
        byte2[i] =  tmp_num & 0xff;
        tmp_num = tmp_num >> 8;
    }
    return byte2;
}



//计算CRC值
+(NSData *) calCRC:(NSData *)src{
    if(src != nil && [src length] > 0){
        int len = [src length];
        Byte *byteData = (Byte*)malloc(len);
        memcpy(byteData, [src bytes], len);
        unsigned short crc = 0;
        Byte *r = (Byte*)malloc(2);
        while (len-- > 0)
            crc = ccitt_table[(crc >> 8 ^ *byteData++) & 0xff] ^ (crc << 8);
        crc = ~crc;//取反
        r[0] = crc & 0XFF;
        r[1] = (crc >> 8) & 0xFF;
        NSData *returndata = [[NSData alloc] initWithBytes:r length:2];
        return returndata;
    }else{
        return nil;
    }
}





//下载公钥
+(NSData *) COMMAND_TAG_CUPA_1;
{
    
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_1 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}

//下载AID
+(NSData *) COMMAND_TAG_CUPA_2;
{
    
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_2 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}

//回响测试
+(NSData *) COMMAND_TAG_CUPA_03; 
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_3 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}

//参数上送
+(NSData *) COMMAND_TAG_CUPA_04;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_4 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}

//参数下载
+(NSData *) COMMAND_TAG_CUPA_05;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_5 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//下载黑名单
+(NSData *) COMMAND_TAG_CUPA_06;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_6 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//Qpboc非接电子现金快速支付
+(NSData *) COMMAND_TAG_CUPA_07;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_7 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
 
}
//Qpboc接触电子现金快速支付
+(NSData *) COMMAND_TAG_CUPA_08;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_8 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//现金充值
+(NSData *) COMMAND_TAG_CUPA_09;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_9 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
 
}
//指定账户圈存
+(NSData *) COMMAND_TAG_CUPA_10;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_10 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//非指定账户圈存
+(NSData *) COMMAND_TAG_CUPA_11;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_11 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//现金充值撤销
+(NSData *) COMMAND_TAG_CUPA_12;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_12 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];

}
//IC卡余额
+(NSData *) COMMAND_TAG_CUPA_13;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_13 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//IC明细查询
+(NSData *) COMMAND_TAG_CUPA_14;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_14 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//IC脱机退货
+(NSData *) COMMAND_TAG_CUPA_15;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_15 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//分期付款消费
+(NSData *) COMMAND_TAG_CUPA_16;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_16 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//分期付款撤销
+(NSData *) COMMAND_TAG_CUPA_17;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_17 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//余额查询
+(NSData *) COMMAND_TAG_CUPA_18;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_18 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//手机无卡预约消费
+(NSData *) COMMAND_TAG_CUPA_19;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_19 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//手机无卡预约消费撤销
+(NSData *) COMMAND_TAG_CUPA_20;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_20 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//磁条卡现金充值账户验证
+(NSData *) COMMAND_TAG_CUPA_21;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_21 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片支付消费
+(NSData *) COMMAND_TAG_CUPA_22;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_22 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片支付消费撤销
+(NSData *) COMMAND_TAG_CUPA_23;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_23 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片支退货
+(NSData *) COMMAND_TAG_CUPA_24;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_24 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片预授权
+(NSData *) COMMAND_TAG_CUPA_25;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_25 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片预授权撤销
+(NSData *) COMMAND_TAG_CUPA_26;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_26 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片预授权完成（请求）
+(NSData *) COMMAND_TAG_CUPA_27;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_27 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片预授权完成（通知）
+(NSData *) COMMAND_TAG_CUPA_28;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_28 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片预授权完成（请求）撤销
+(NSData *) COMMAND_TAG_CUPA_29;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_29 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//银联手机芯片余额查询
+(NSData *) COMMAND_TAG_CUPA_30;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_30 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//发卡行积分消费
+(NSData *) COMMAND_TAG_CUPA_31;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_31 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//联盟积分消费
+(NSData *) COMMAND_TAG_CUPA_32;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_32 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//发卡行积分消费撤销
+(NSData *) COMMAND_TAG_CUPA_33;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_33 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//联盟积分消费消费撤销
+(NSData *) COMMAND_TAG_CUPA_34;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_34 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//联盟积分查询
+(NSData *) COMMAND_TAG_CUPA_35;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_35 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//联盟积分退货
+(NSData *) COMMAND_TAG_CUPA_36;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_36 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//发卡行积分消费撤销
+(NSData *) COMMAND_TAG_CUPA_37;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_37 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购消费
+(NSData *) COMMAND_TAG_CUPA_38;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_38 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购消费撤销
+(NSData *) COMMAND_TAG_CUPA_39;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_39 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购撤销
+(NSData *) COMMAND_TAG_CUPA_40;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_40 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购预授权
+(NSData *) COMMAND_TAG_CUPA_41;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_41 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购预授权撤销
+(NSData *) COMMAND_TAG_CUPA_42;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_42 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购预授权完成请求
+(NSData *) COMMAND_TAG_CUPA_43;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_43 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}
//订购预授权完成请求撤销
+(NSData *) COMMAND_TAG_CUPA_44;
{
    NSData *iccommand = [self setTLV : TAG_TRANS_TYPE : (Byte *)TAG_CUPA_44 : 1];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:1];
    [arrays addObject:iccommand];
    return [self setTotalTLV :arrays];
}


//联机签到
+(NSData *) COMMAND_TAG_CUPA_60;
{
    uint8_t operid[2] = {0x30,0x31};
    NSData *T_LOGIN = [self setTLV:TAG_TRANS_TYPE :(Byte *)TAG_CUPA_60 :1];
    NSData *T_LOGIN_NUMBER = [self setTLV:TAG_OPERID :operid : 2];
    NSMutableArray *arrays = [[NSMutableArray alloc] initWithCapacity:3];
    [arrays addObject:T_LOGIN];
    [arrays addObject:T_LOGIN_NUMBER];
    NSData* result = [QuanYiPos setTotalTLV:arrays];
    return result;
}

@end
