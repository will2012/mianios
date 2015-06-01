//
//  PostDetailViewController.m
//  mian
//
//  Created by will.song on 15/5/31.
//  Copyright (c) 2015年 wc. All rights reserved.
//

#import "PostDetailViewController.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    //NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.view addSubview: self.webView];
    NSData* jsonData = [self.post dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    NSMutableString *mutableString = [[NSMutableString alloc]init];
    for (NSString *item in array) {
        NSLog(@"item:%@",item);
        [mutableString appendString:item];
        [mutableString appendString:@"<br/>"];
    }
    NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Pictures"];
    [self.webView loadHTMLString: mutableString baseURL:url];
    //[self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
