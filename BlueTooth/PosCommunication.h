//
//  PosCommunication.h
//  QuanYiPos
//
//  Created by user on 13-3-28.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "QuanYiPos.h"
#import "SocketConnection.h"

@interface PosCommunication : NSObject<NSStreamDelegate>
{
   	NSString		*_protocolString;
    int result;
    int package8583length;

}
@property (nonatomic,retain) EAAccessory		*_accessory;
@property (nonatomic,retain) EASession          *session;
+(PosCommunication *)sharedInstanceMethod;
-(Boolean) connectToDevice : (NSString *)protocalstring;

@end
