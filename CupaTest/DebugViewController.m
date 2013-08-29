//
//  DebugViewController.m
//  CupaTest
//
//  Created by user on 13-6-9.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import "DebugViewController.h"


#define TRANS_TYPE_1 @"下载公钥"
#define TRANS_TYPE_2 @"下载AID"
#define TRANS_TYPE_3 @"回响测试"
#define TRANS_TYPE_4 @"参数上送"
#define TRANS_TYPE_5 @"参数下载"
#define TRANS_TYPE_6 @"下载黑名单"
#define TRANS_TYPE_7 @"Qpboc非接电子现金快速支付"
#define TRANS_TYPE_8 @"Qpboc接触电子现金快速支付"
#define TRANS_TYPE_9 @"现金充值"
#define TRANS_TYPE_10 @"指定账户圈存"
#define TRANS_TYPE_11 @"非指定账户圈存"
#define TRANS_TYPE_12 @"现金充值撤销"
#define TRANS_TYPE_13 @"IC余额查询"
#define TRANS_TYPE_14 @"IC明细查询"
#define TRANS_TYPE_15 @"IC脱机退货"
#define TRANS_TYPE_16 @"分期付款消费"
#define TRANS_TYPE_17 @"分期付款撤销"
#define TRANS_TYPE_18 @"余额查询"
#define TRANS_TYPE_19 @"手机无卡预约消费"
#define TRANS_TYPE_20 @"手机无卡预约消费撤销"
#define TRANS_TYPE_21 @"磁条卡现金充值账户验证"
#define TRANS_TYPE_22 @"磁条卡账户充值"
#define TRANS_TYPE_23 @"银联手机芯片支付消费"
#define TRANS_TYPE_24 @"银联手机芯片支付消费撤销"
#define TRANS_TYPE_25 @"银联手机芯片支退货"
#define TRANS_TYPE_26 @"银联手机芯片预授权"
#define TRANS_TYPE_27 @"银联手机芯片预授权撤销"
#define TRANS_TYPE_28 @"银联手机芯片预授权完成（请求）"
#define TRANS_TYPE_29 @"银联手机芯片预授权完成（通知）"
#define TRANS_TYPE_30 @"银联手机芯片预授权完成（请求）撤销"
#define TRANS_TYPE_31 @"银联手机芯片余额查询"
#define TRANS_TYPE_32 @"发卡行积分消费"
#define TRANS_TYPE_33 @"联盟积分消费"
#define TRANS_TYPE_34 @"发卡行积分消费撤销"
#define TRANS_TYPE_35 @"联盟积分消费消费撤销"
#define TRANS_TYPE_36 @"联盟积分查询"
#define TRANS_TYPE_37 @"联盟积分退货"
#define TRANS_TYPE_38 @"订购消费"
#define TRANS_TYPE_39 @"订购消费撤销"
#define TRANS_TYPE_40 @"订购撤销"
#define TRANS_TYPE_41 @"订购预授权"
#define TRANS_TYPE_42 @"订购预授权撤销"
#define TRANS_TYPE_43 @"订购预授权完成请求"
#define TRANS_TYPE_44 @"订购预授权完成请求撤销"
#define TRANS_TYPE_45 @"订购预授权完成请求通知"
#define TRANS_TYPE_46 @"预授权"
#define TRANS_TYPE_47 @"预授权完成请求"
#define TRANS_TYPE_48 @"预授权完成请求通知"
#define TRANS_TYPE_49 @"预授权撤销"
#define TRANS_TYPE_50 @"预授权完成撤销"
#define TRANS_TYPE_51 @"离线结算"
#define TRANS_TYPE_52 @"结算调整"
#define TRANS_TYPE_53 @"重打最后一笔"
#define TRANS_TYPE_54 @"重打任意笔"
#define TRANS_TYPE_55 @"打印明细"
#define TRANS_TYPE_56 @"打印交易汇总"
#define TRANS_TYPE_57 @"打印上批结算清单"
#define TRANS_TYPE_58 @"打印未上送的脱机明细"
#define TRANS_TYPE_59 @"打印上送被拒绝的脱机明细"
#define TRANS_TYPE_60 @"联机签到"
#define TRANS_TYPE_61 @"收银员积分签到"
#define TRANS_TYPE_62 @"联机签退"
#define TRANS_TYPE_63 @"结算"
#define TRANS_TYPE_64 @"消费"
#define TRANS_TYPE_65 @"消费撤销"
#define TRANS_TYPE_66 @"退货"


static NSString *MESSAGE_LOG = @"MESSAGE_LOG";

@interface DebugViewController ()

@end

@implementation DebugViewController
@synthesize transtype;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleRefrushMessage :) name:MESSAGE_LOG object:nil];
    logtextview.editable = false;
    
 }

- (void)handleRefrushMessage : (NSNotification *) notification {
    NSString  *content = [[notification userInfo] objectForKey:MESSAGE_LOG];
    NSString *poslog = @"POS->Phone:\n";
    
    content = [poslog stringByAppendingFormat:@"%@",content];
    
    [self setLog:content];
}

-(IBAction) clearLog
{
    logtextview.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setLog : (NSString *)str
{
    NSString *logtextcontent = logtextview.text;
    logtextview.text = [logtextcontent stringByAppendingFormat:@"%@",str];
}
//self sendSocketMessageToServer:sendtoserver];

-(IBAction) dostartTrans
{
    if([transtype isEqualToString:TRANS_TYPE_13]){//IC卡余额查询
        NSData *icardbalance = [QuanYiPos COMMAND_TAG_CUPA_13];
        NSString *log = @"Phone -> Pos \n";
        log = [log stringByAppendingFormat:@"%@",[QuanYiPos getHexString:(Byte*)icardbalance.bytes start:0 end:icardbalance.length]];
        [self setLog:log];
        [[PosCommunication sharedInstanceMethod].session.outputStream write:(Byte*)icardbalance.bytes maxLength:icardbalance.length];

    }else if([transtype isEqualToString:TRANS_TYPE_3]){//回响测试
        NSData *command = [QuanYiPos COMMAND_TAG_CUPA_03];
        NSString *log = @"Phone -> Pos \n";
        log = [log stringByAppendingFormat:@"%@",[QuanYiPos getHexString:(Byte*)command.bytes start:0 end:command.length]];
        [self setLog:log];
        [[PosCommunication sharedInstanceMethod].session.outputStream write:(Byte*)command.bytes maxLength:command.length];
    }else if ([transtype isEqualToString:TRANS_TYPE_60]){//联机签到
        NSData *command = [QuanYiPos COMMAND_TAG_CUPA_60];
        NSString *log = @"Phone -> Pos \n";
        log = [log stringByAppendingFormat:@"%@",[QuanYiPos getHexString:(Byte*)command.bytes start:0 end:command.length]];
        [self setLog:log];
        [[PosCommunication sharedInstanceMethod].session.outputStream write:(Byte*)command.bytes maxLength:command.length];
    }
}

@end
