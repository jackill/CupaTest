//
//  DebugViewController.h
//  CupaTest
//
//  Created by user on 13-6-9.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuanYiPos.h"
#import "PosCommunication.h"
#import "MBProgressHUD.h"

@interface DebugViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    IBOutlet UITextField *amounttext;
    IBOutlet UITextView *logtextview;

}
-(IBAction) dostartTrans;
-(IBAction) clearLog;

@property (nonatomic,retain)    NSString *transtype;

@end
