//
//  PostsControllerViewController.m
//  mian
//
//  Created by will.song on 15/5/30.
//  Copyright (c) 2015年 wc. All rights reserved.
//
#import "PostsControllerViewController.h"
#import "PostDetailViewController.h"
#import "MJRefresh.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface PostsControllerViewController ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *data;
@property ( nonatomic) NSInteger page;

@end

@implementation PostsControllerViewController {
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];//指定位置大小
    self.array = [[NSMutableArray alloc] init];
    [self.view addSubview: self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.page = 0;
    [self getPosts: self.page];
      __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf cleanData];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        //[self loadNewData];
        [weakSelf loadNewData];
    }];
    }


-(void) showMBProgress{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
    
    //[HUD hide:YES afterDelay:2];
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

-(void) loadNewData{
   [self getPosts: self.page];
}

-(void) cleanData{
    self.page = 0;
    [self.array removeAllObjects];
    [self getPosts: self.page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getPosts:(NSInteger) page{
    [self showMBProgress];
    NSString *url = [NSString stringWithFormat: @"http://115.29.106.123:8888/v1/posts/%@/%d", self.category_id, page];
    NSLog(@"%@", url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        NSLog(@"%@", responseObject);
        for (id key in responseObject)
        {
            [self.array addObject:key];
            
        }
        [self.tableView reloadData];
        self.page++;
        [self.tableView.footer endRefreshing];
         [self.tableView.header endRefreshing];
        [HUD hide:YES ];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    int row = indexPath.row;
    NSDictionary *pair = [self.array objectAtIndex:row];
    NSLog(@"%@", [pair objectForKey: @"title"]);
    cell.textLabel.text = [pair objectForKey: @"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSDictionary *dictionary = [self.mutableArray objectAtIndex:[indexPath row]];  //这个表示选中的那个cell上的数据
    // NSString *titileString = [dictionary objectForKey: @"name"];
    // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:titileString delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
    // [alert show];
    int row = indexPath.row;
    NSDictionary *dict = [self.array objectAtIndex: row];
    NSString *category_id = [dict objectForKey: @"post_content"];
    NSLog(@"%@", category_id);
    PostDetailViewController *postsController = [[PostDetailViewController alloc]init];
    postsController.post = category_id;
    postsController.title = @"详情";
    [self.navigationController pushViewController:postsController animated: YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
