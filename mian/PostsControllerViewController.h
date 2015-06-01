//
//  PostsControllerViewController.h
//  mian
//
//  Created by will.song on 15/5/30.
//  Copyright (c) 2015年 wc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsControllerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) NSNumber *category_id;
@property (retain, nonatomic) NSMutableArray * array;
@property(nonatomic, retain) UITableView *tableView;
@end
