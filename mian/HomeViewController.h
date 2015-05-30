//
//  RootViewController.h
//  mian
//
//  Created by will.song on 15/5/28.
//  Copyright (c) 2015年 wc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) NSMutableArray *mutableArray;


@end
