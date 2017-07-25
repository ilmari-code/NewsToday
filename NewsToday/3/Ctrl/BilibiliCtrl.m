//
//  BilibiliCtrl.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/7/20.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "BilibiliCtrl.h"
#import "LoadHomeDataApi.h"
@interface BilibiliCtrl ()

@end

@implementation BilibiliCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor flatPinkColor];
    
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSDictionary *dict = @{@"a":@"list",@"c":@"data",@"type":@"1"};
    LoadHomeDataApi *request = [[LoadHomeDataApi alloc] initWithDict:nil];
    
    if ([request loadCacheWithError:nil]) {
        NSDictionary *json = [request responseJSONObject];
        NSLog(@"json = %@", json);
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"充公");
        NSLog(@"%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.error);
    }];
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
