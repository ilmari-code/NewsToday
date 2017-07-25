//
//  HomeViewController.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/14.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsTableView.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[YYFPSLabel new]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor flatWhiteColor];
    [self setupSubViews];
}

- (void)setupSubViews{
    NewsTableView *tableView = [[NewsTableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
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
