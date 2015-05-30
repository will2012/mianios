//
//  RootViewController.m
//  mian
//
//  Created by will.song on 15/5/28.
//  Copyright (c) 2015年 wc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HomeViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];//指定位置大小
    self.mutableArray = [[NSMutableArray alloc] init];
    [self.view addSubview: self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getCategories];
    
}

- (void)getCategories{
    NSString *url = [NSString stringWithFormat: @"http://115.29.106.123:8888/v1/categories"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        for (id key in responseObject)
        {
            [self.mutableArray addObject:key];
            
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    NSLog(@"%@", url);}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    int row = indexPath.row;
    NSDictionary *pair = [self.mutableArray objectAtIndex:row];
    NSLog(@"%@", [pair objectForKey: @"id"]);
    cell.textLabel.text = [pair objectForKey: @"name"];
    return cell;
}


@end
