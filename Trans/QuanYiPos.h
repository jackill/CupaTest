//
//  QuanYiPos.h
//  QuanYiPos
//
//  Created by user on 13-4-1.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
 

//CUPA TEST

const static  uint8_t TAG_CUPA_1[1] = {0x01};//下载公钥
const static  uint8_t TAG_CUPA_2[1] = {0x02};//下载AID
const static  uint8_t TAG_CUPA_3[1] = {0x03};//回响测试
const static  uint8_t TAG_CUPA_4[1] = {0x04};//参数上送
const static  uint8_t TAG_CUPA_5[1] = {0x05};//参数下载
const static  uint8_t TAG_CUPA_6[1] = {0x06};//下载黑名单
const static  uint8_t TAG_CUPA_7[1] = {0x10};//Qpboc非接电子现金快速支付
const static  uint8_t TAG_CUPA_8[1] = {0x11};//Qpboc接触电子现金快速支付
const static  uint8_t TAG_CUPA_9[1] = {0x12};//现金充值
const static  uint8_t TAG_CUPA_10[1] = {0x13};//指定账户圈存
const static  uint8_t TAG_CUPA_11[1] = {0x14};//非指定账户圈存
const static  uint8_t TAG_CUPA_12[1] = {0x15};//现金充值撤销
const static  uint8_t TAG_CUPA_13[1] = {0x16};//IC余额查询
const static  uint8_t TAG_CUPA_14[1] = {0x17};//IC明细查询
const static  uint8_t TAG_CUPA_15[1] = {0x18};//IC脱机退货

const static  uint8_t TAG_CUPA_16[1] = {0x19};//分期付款消费
const static  uint8_t TAG_CUPA_17[1] = {0x1A};//分期付款撤销
const static  uint8_t TAG_CUPA_18[1] = {0x1B};//余额查询
const static  uint8_t TAG_CUPA_19[1] = {0x1C};//手机无卡预约消费
const static  uint8_t TAG_CUPA_20[1] = {0x1D};//手机无卡预约消费撤销
const static  uint8_t TAG_CUPA_21[1] = {0x1E};//磁条卡现金充值账户验证
const static  uint8_t TAG_CUPA_22[1] = {0x20};//银联手机芯片支付消费
const static  uint8_t TAG_CUPA_23[1] = {0x21};//银联手机芯片支付消费撤销

const static  uint8_t TAG_CUPA_24[1] = {0x22};//银联手机芯片支退货
const static  uint8_t TAG_CUPA_25[1] = {0x23};//银联手机芯片预授权
const static  uint8_t TAG_CUPA_26[1] = {0x24};//银联手机芯片预授权撤销
const static  uint8_t TAG_CUPA_27[1] = {0x25};//银联手机芯片预授权完成（请求）
const static  uint8_t TAG_CUPA_28[1] = {0x26};//银联手机芯片预授权完成（通知）
const static  uint8_t TAG_CUPA_29[1] = {0x27};//银联手机芯片预授权完成（请求）撤销
const static  uint8_t TAG_CUPA_30[1] = {0x28};//银联手机芯片余额查询
const static  uint8_t TAG_CUPA_31[1] = {0x29};//发卡行积分消费
const static  uint8_t TAG_CUPA_32[1] = {0x2A};//联盟积分消费
const static  uint8_t TAG_CUPA_33[1] = {0x2B};//发卡行积分消费撤销




const static  uint8_t TAG_CUPA_34[1] = {0x2C};//联盟积分消费消费撤销
const static  uint8_t TAG_CUPA_35[1] = {0x2D};//联盟积分查询
const static  uint8_t TAG_CUPA_36[1] = {0x2E};//联盟积分退货
const static  uint8_t TAG_CUPA_37[1] = {0x2B};//发卡行积分消费撤销
const static  uint8_t TAG_CUPA_38[1] = {0x30};//订购消费
const static  uint8_t TAG_CUPA_39[1] = {0x31};//订购消费撤销
const static  uint8_t TAG_CUPA_40[1] = {0x32};//订购撤销
const static  uint8_t TAG_CUPA_41[1] = {0x33};//订购预授权
const static  uint8_t TAG_CUPA_42[1] = {0x34};//订购预授权撤销
const static  uint8_t TAG_CUPA_43[1] = {0x35};//订购预授权完成请求
const static  uint8_t TAG_CUPA_44[1] = {0x36};//订购预授权完成请求撤销

const static  uint8_t TAG_CUPA_45[1] = {0x37};//订购预授权完成请求通知
const static  uint8_t TAG_CUPA_46[1] = {0x40};//预授权
const static  uint8_t TAG_CUPA_47[1] = {0x41};//预授权完成请求
const static  uint8_t TAG_CUPA_48[1] = {0x42};//预授权完成请求通知
const static  uint8_t TAG_CUPA_49[1] = {0x43};//预授权撤销
const static  uint8_t TAG_CUPA_50[1] = {0x44};//预授权完成撤销
const static  uint8_t TAG_CUPA_51[1] = {0x50};//离线结算


const static  uint8_t TAG_CUPA_52[1] = {0x51};//结算调整
const static  uint8_t TAG_CUPA_53[1] = {0x60};//重打最后一笔
const static  uint8_t TAG_CUPA_54[1] = {0x61};//重打任意笔
const static  uint8_t TAG_CUPA_55[1] = {0x62};//打印明细
const static  uint8_t TAG_CUPA_56[1] = {0x63};//打印交易汇总
const static  uint8_t TAG_CUPA_57[1] = {0x64};//打印上批结算清单
const static  uint8_t TAG_CUPA_58[1] = {0x65};//打印未上送的脱机明细
const static  uint8_t TAG_CUPA_59[1] = {0x66};//打印上送被拒绝的脱机明细
const static  uint8_t TAG_CUPA_60[1] = {0x70};//联机签到
const static  uint8_t TAG_CUPA_61[1] = {0x71};//收银员积分签到
const static  uint8_t TAG_CUPA_62[1] = {0x72};//联机签退

const static  uint8_t TAG_CUPA_63[1] = {0x73};//结算
const static  uint8_t TAG_CUPA_64[1] = {0x90};//消费
const static  uint8_t TAG_CUPA_65[1] = {0x91};//消费撤销
const static  uint8_t TAG_CUPA_66[1] = {0x92};//退货





 

//
const static  Byte TAG_START = 0x03;
const static  Byte TAG_ERROR = (Byte)0x04;
const static  Byte TAG_STATE = (Byte)0x10;
const static  Byte TAG_TRANS_TYPE = (Byte)0x11;
const static  Byte TAG_TRANS_AMOUNT = (Byte)0x12;
const static  Byte TAG_TRANS_ID = (Byte)0x13;
const static  Byte TAG_IOS8583 = (Byte)0x14;
const static  Byte TAG_RESPONSE_CODE = (Byte)0x15;
const static  Byte TAG_RESPONSE_CODE_INFO = (Byte)0x16;
const static  Byte TAG_CARD_NUMBER = (Byte)0x17;//二磁信息
const static  Byte TAG_ACCOUNT_BALANCE = (Byte)0x18;
const static  Byte TAG_PAY_WAY = (Byte)0x19;
const static  Byte TAG_INSTALLMENT_NUMBER = (Byte)0x20;
const static  Byte TAG_TRANS_DATE = (Byte)0x22;
const static  Byte TAG_TRANS_TIME = (Byte)0x23;
const static  Byte TAG_ORDER_NUMBER = (Byte)0x24;
const static  Byte TAG_OPERID = (Byte)0x25;
const static  Byte TAG_OPER_NEWPASSWORD = (Byte)0x26;
const static  Byte TAG_ADDITINAL_INFO = (Byte)0x27;
const static  Byte TAG_TRANS_TOTLA_NUMBER = (Byte)0x28;
const static  Byte TAG_TRANS_TOTAL_AMOUNT = (Byte)0x29;
const static  Byte TAG_TRANS_OPERNEWPASSWORD = (Byte)0x2A;
const static  Byte TAG_TRANS_BATCHSTATE = (Byte)0x2B;
const static  Byte TAG_TRANS_WAIT_PAY_AMOUNT = (Byte)0x2C;//待支付金额
const static  Byte TAG_TRANS_PAIED_AMOUNT = (Byte)0x2D;//已支付金额
const static  Byte TAG_TRANS_SCANBARCODE_MSR = (Byte)0x2E;//用于区别是否扫描2磁信息

//public static final byte[] TAG_SWIPCARD_BATCH = new byte[]{(byte)0x33,(byte)0x00,(byte)0x00};//刷卡结算
const static uint8_t TAG_PASSWORD_BATCH[3] = {0x32,0x00,0x00};//输密码结算
const static uint8_t TAG_BANKCARD_BATCH[3] = {0x30,0x00,0x00};//银行卡结算
const static uint8_t TAG_POINTCARD_BATCH[3] = {0x31,0x00,0x00};//积点卡结算


//TAG VALUE
const static  uint8_t TAG_TRANS_LOGIN[1] = {0x01};//签到
const static  uint8_t TAG_TRANS_SALE[1] = {0x02};//消费
const static  uint8_t TAG_TRANS_PRING[1] = {0x11};//权宜打印
const static  uint8_t TAG_TRANS_BALANCE[1] = {0x04};//余额查询
const static  uint8_t TAG_TRANS_VOID[1] = {0x03};//消费撤消
const static  uint8_t TAG_TRANS_BATCH[1] = {0x05};//结算
const static  uint8_t TAG_TRANS_SEARCHSTATE[1] = {0x06};//状态查询
const static  uint8_t TAG_TRANS_LOGOUT[1] = {0x07};//签退
const static  uint8_t TAG_TRANS_ONLINEPOSEARCH[1] ={0x08};//网上订单POS查询
const static  uint8_t TAG_TRANS_ONLINEPOSBATCH[1] = {0x09};//网上订单POS结算
const static  uint8_t TAG_TRANS_ONLINENOTBATCHLIST[1] = {0x10};//网上未结算订单列表
const static  uint8_t TAG_TRANS_OKCARDSALE[1] = {0x12};//会员消费——Ok点消费 0x12【tag12(金额)，tag19（31  00  00）
const static  uint8_t TAG_TRANS_BANKCARDSALE[1] = {0x13};//会员消费——银行卡消费 0x13【tag12(金额)，tag19（30  00  00）
const static  uint8_t TAG_TRANS_REPRINT[1] = {0x14};//重打印最后一笔
const static  uint8_t TAG_TRANS_SCANBARCODE_MSR_VALUE_TRACKTWO[1] = {0x30};//扫描2磁
const static  uint8_t TAG_TRANS_SCANBARCODE_MSR_VALUE_NO_TRACKTWO[1] = {0x31};//不扫描2磁

@interface QuanYiPos : NSObject
{
    
}
+(NSString *)getHexString:(void *)buffer start:(int)startIndex end:(int)endIndex;
+(NSData *) setTLV: (Byte) Tag : (Byte *)value : (int)length;
+(Byte *) intToByte2:(int) number;
+(NSData *) setTotalTLV:  (NSMutableArray *)parameters;
+(NSData *) calCRC:(NSData *)src;
//////

//CUPA IC CARD BALANCE TEST
+(NSData *) COMMAND_TAG_CUPA_03;
+(NSData *) COMMAND_TAG_CUPA_1;
+(NSData *) COMMAND_TAG_CUPA_2;
+(NSData *) COMMAND_TAG_CUPA_04;
+(NSData *) COMMAND_TAG_CUPA_05;
+(NSData *) COMMAND_TAG_CUPA_06;
+(NSData *) COMMAND_TAG_CUPA_07;
+(NSData *) COMMAND_TAG_CUPA_08;
+(NSData *) COMMAND_TAG_CUPA_09;
+(NSData *) COMMAND_TAG_CUPA_10;
+(NSData *) COMMAND_TAG_CUPA_11;
+(NSData *) COMMAND_TAG_CUPA_12;
+(NSData *) COMMAND_TAG_CUPA_13;//IC卡余额查询
+(NSData *) COMMAND_TAG_CUPA_14;
+(NSData *) COMMAND_TAG_CUPA_15;
+(NSData *) COMMAND_TAG_CUPA_16;
+(NSData *) COMMAND_TAG_CUPA_17;
+(NSData *) COMMAND_TAG_CUPA_18;
+(NSData *) COMMAND_TAG_CUPA_19;
+(NSData *) COMMAND_TAG_CUPA_20;
+(NSData *) COMMAND_TAG_CUPA_21;
+(NSData *) COMMAND_TAG_CUPA_22;
+(NSData *) COMMAND_TAG_CUPA_23;
//
+(NSData *) COMMAND_TAG_CUPA_24;
+(NSData *) COMMAND_TAG_CUPA_25;
+(NSData *) COMMAND_TAG_CUPA_26;
+(NSData *) COMMAND_TAG_CUPA_27;
+(NSData *) COMMAND_TAG_CUPA_28;
+(NSData *) COMMAND_TAG_CUPA_29;
+(NSData *) COMMAND_TAG_CUPA_30;
+(NSData *) COMMAND_TAG_CUPA_31;
+(NSData *) COMMAND_TAG_CUPA_32;
+(NSData *) COMMAND_TAG_CUPA_33;

+(NSData *) COMMAND_TAG_CUPA_34;
+(NSData *) COMMAND_TAG_CUPA_35;
+(NSData *) COMMAND_TAG_CUPA_36;
+(NSData *) COMMAND_TAG_CUPA_37;
+(NSData *) COMMAND_TAG_CUPA_38;
+(NSData *) COMMAND_TAG_CUPA_39;
+(NSData *) COMMAND_TAG_CUPA_40;
+(NSData *) COMMAND_TAG_CUPA_41;
+(NSData *) COMMAND_TAG_CUPA_42;
+(NSData *) COMMAND_TAG_CUPA_43;
+(NSData *) COMMAND_TAG_CUPA_44;


+(NSData *) COMMAND_TAG_CUPA_60;


@end
