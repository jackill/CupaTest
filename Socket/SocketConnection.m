//
//  SocketConnection.m
//  UniPayAssistant
//
//  Created by user on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SocketConnection.h"

@implementation SocketConnection
@synthesize client;

+(SocketConnection *)sharedSingleton
{
    static SocketConnection *sharedSingleton;
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[SocketConnection alloc] init];
        return sharedSingleton;
    }
}


- (int) connectServer: (NSString *) hostIP port : (int) hostPort : (id) delegate{
    if (client == nil) {
        client = [[AsyncSocket alloc]initWithDelegate:delegate];  
        NSError *err = nil;  
        if (![client connectToHost:hostIP onPort:hostPort error:&err]) {  
            NSLog(@"Socket Connect Error : %d,%@", [err code], [err localizedDescription]);
			
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[@"连接失败： "   
//																	 stringByAppendingString:hostIP]   
//                                                            message:[[[NSString alloc]initWithFormat:@"%@",[err code]] stringByAppendingString:[err localizedDescription]]   
//                                                           delegate:self   
//                                                  cancelButtonTitle:@"OK"  
//                                                  otherButtonTitles:nil];  
      //      [alert show];
            
            return SRV_CONNECT_FAIL;  
        } else {  
            NSLog(@"Connect success!");  
            return SRV_CONNECT_SUC;  
        }  
    }  
    else {  
        [client readDataWithTimeout:-1 tag:0];  
        return SRV_CONNECTED;  
    }  
}  




@end
