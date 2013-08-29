//
//  SocketConnection.h
//  UniPayAssistant
//
//  Created by user on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


#define SRV_CONNECTED 0  
#define SRV_CONNECT_SUC 1  
#define SRV_CONNECT_FAIL 2  
#define HOST_IP @"59.175.233.50"
#define HOST_PORT 8001
//ipaddress = "59.175.233.50";
//port = 8001;

@interface SocketConnection : NSObject{
    AsyncSocket *client;  

}

+(SocketConnection *)sharedSingleton;

@property (nonatomic) AsyncSocket *client;  
- (int) connectServer: (NSString *) hostIP port : (int) hostPort : (id) delegate; 


@end
