

//
//  RootTabBarCtrl.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/14.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "RootTabBarCtrl.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MineViewController.h"
#import "BilibiliCtrl.h"
@interface RootTabBarCtrl ()

@end

@implementation RootTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildrenCtrlName:[HomeViewController class] WithTitle:@"首页" WithImageName:nil WithSelectedImageName:nil BadgeValue:nil];

    
    [self setupChildrenCtrlName:[SecondViewController class] WithTitle:@"二页" WithImageName:nil WithSelectedImageName:nil BadgeValue:nil];
    
    [self setupChildrenCtrlName:[BilibiliCtrl class] WithTitle:@"三页" WithImageName:nil WithSelectedImageName:nil BadgeValue:nil];
    
    [self setupChildrenCtrlName:[MineViewController class] WithTitle:@"我" WithImageName:nil WithSelectedImageName:nil BadgeValue:nil];
}



- (void)setupChildrenCtrlName:(Class)className WithTitle:(NSString *)title WithImageName:(NSString *)imageName WithSelectedImageName:(NSString *)selectedImageName BadgeValue:(NSString *)badgeValue{
    
    UIViewController *viewCtrl = [[className alloc]init];
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:viewCtrl];
    
    navCtrl.tabBarItem.title = title;
    [navCtrl.tabBarItem setBadgeValue:badgeValue];
    [navCtrl.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [navCtrl.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImageName]];
    
    [navCtrl.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:15.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
    [navCtrl.tabBarItem setImageInsets:UIEdgeInsetsMake(-3, 0, 3, 0)];
    
    [self addChildViewController:navCtrl];
    
    
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
