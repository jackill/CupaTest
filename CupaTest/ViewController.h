//
//  ViewController.h
//  CupaTest
//
//  Created by user on 13-6-9.
//  Copyright (c) 2013年 haixin.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosCommunication.h"
#import "QuanYiPos.h"
#import "DebugViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableview;
    Boolean connected;
}
@property (nonatomic,retain)    NSMutableArray *booklistcontent;

@end
