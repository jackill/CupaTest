//
//  ViewController.m
//  CupaTest
//
//  Created by user on 13-6-9.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize booklistcontent;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"CUPA 测试";
    connected = false;
    booklistcontent = [[NSMutableArray alloc] initWithCapacity:4];
    
    
    [booklistcontent addObject:@"下载公钥"]; //0
    [booklistcontent addObject:@"下载AID"]; //1
    [booklistcontent addObject:@"回响测试"]; //2
    [booklistcontent addObject:@"参数上送"]; //3
    [booklistcontent addObject:@"参数下载"]; //4
    [booklistcontent addObject:@"下载黑名单"];//5
    [booklistcontent addObject:@"Qpboc非接电子现金快速支付"];//6
    [booklistcontent addObject:@"Qpboc接触电子现金快速支付"];//7
    [booklistcontent addObject:@"现金充值"];//8
    [booklistcontent addObject:@"指定账户圈存"];//9
    [booklistcontent addObject:@"非指定账户圈存"];//10
    [booklistcontent addObject:@"现金充值撤销"];//11
    [booklistcontent addObject:@"IC余额查询"];//12
    [booklistcontent addObject:@"IC明细查询"];//13
    [booklistcontent addObject:@"IC脱机退货"];//14
    [booklistcontent addObject:@"分期付款消费"];//15
    [booklistcontent addObject:@"分期付款撤销"];//16
    [booklistcontent addObject:@"余额查询"];//17
    [booklistcontent addObject:@"手机无卡预约消费"];//18
    
    [booklistcontent addObject:@"手机无卡预约消费"];//19
    [booklistcontent addObject:@"手机无卡预约消费撤销"];//20
    [booklistcontent addObject:@"磁条卡现金充值账户验证"];//21
    [booklistcontent addObject:@"磁条卡账户充值"];//22
    [booklistcontent addObject:@"银联手机芯片支付消费"];//23
    [booklistcontent addObject:@"银联手机芯片支付消费撤销"];//24
    [booklistcontent addObject:@"银联手机芯片支付退货"];//25
    [booklistcontent addObject:@"银联手机芯片预授权"];//26
    [booklistcontent addObject:@"银联手机芯片预授权撤销"];//27
    [booklistcontent addObject:@"银联手机芯片预授权完成（请求）"];//28
    [booklistcontent addObject:@"银联手机芯片预授权完成（通知）"];//29

    [booklistcontent addObject:@"银联手机芯片预授权完成（请求）撤销"];//30
    [booklistcontent addObject:@"银联手机芯片余额查询"];//31
    [booklistcontent addObject:@"发卡行积分消费"];//32
    [booklistcontent addObject:@"联盟积分消费"];//33
    [booklistcontent addObject:@"发卡行积分消费撤销"];//34
    [booklistcontent addObject:@"联盟积分消费消费撤销"];//35
    [booklistcontent addObject:@"联盟积分查询"];//36
    [booklistcontent addObject:@"联盟积分退货"];//37
    [booklistcontent addObject:@"订购消费"];//38
    
    [booklistcontent addObject:@"订购消费"];//39
    [booklistcontent addObject:@"订购消费撤销"];//40
    [booklistcontent addObject:@"订购撤销"];//41
    [booklistcontent addObject:@"订购预授权"];//42
    [booklistcontent addObject:@"订购预授权撤销"];//43
    [booklistcontent addObject:@"订购预授权完成请求"];//44
    [booklistcontent addObject:@"订购预授权完成请求撤销"];//45
    
    [booklistcontent addObject:@"订购预授权完成请求通知"];//46
    [booklistcontent addObject:@"预授权"];//47
    [booklistcontent addObject:@"预授权完成请求"];//48
    [booklistcontent addObject:@"预授权完成请求通知"];//49
    [booklistcontent addObject:@"预授权撤销"];//50

    [booklistcontent addObject:@"预授权完成撤销"];//51
    [booklistcontent addObject:@"离线结算"];//52
    [booklistcontent addObject:@"结算调整"];//53
    [booklistcontent addObject:@"重打最后一笔"];//54

    [booklistcontent addObject:@"重打任意笔"];//55
    [booklistcontent addObject:@"打印明细"];//56
    [booklistcontent addObject:@"打印交易汇总"];//57
    [booklistcontent addObject:@"打印上批结算清单"];//58
    [booklistcontent addObject:@"打印未上送的脱机明细"];//59
    
    [booklistcontent addObject:@"打印上送被拒绝的脱机明细"];//60
    [booklistcontent addObject:@"联机签到"];//61
    [booklistcontent addObject:@"收银员积分签到"];//62
    [booklistcontent addObject:@"联机签退"];//63
    [booklistcontent addObject:@"结算"];//64
    
    [booklistcontent addObject:@"消费"];//65
    [booklistcontent addObject:@"消费撤销"];//66
    [booklistcontent addObject:@"退货"];//67


    
    if([[PosCommunication sharedInstanceMethod] connectToDevice:@"com.bluebamboo.p200"])
    {
        NSLog(@"设备连接成功");
        connected = true;
    }else{
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"设备连接失败！"
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
        connected = false;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSString *product = [self.booklistcontent objectAtIndex:indexPath.row];
    
  /*
    if(connected == false)
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"设备连接失败！"
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
        return;
     }
   */ 
       
        DebugViewController *DC = [[DebugViewController alloc] initWithNibName:@"DebugViewController" bundle:nil];
        DC.title = product;
        DC.transtype = product;
        [self.navigationController pushViewController:DC animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [booklistcontent count];
    
    return [booklistcontent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	
	int index = indexPath.row;
    NSString *product = [self.booklistcontent objectAtIndex:index];
       
  	cell.textLabel.text = product;
    
	return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
