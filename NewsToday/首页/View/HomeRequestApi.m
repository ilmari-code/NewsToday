//
//  HomeRequestApi.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/7/21.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "HomeRequestApi.h"

@implementation HomeRequestApi

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

-(YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"/api/api_open.php?a=list&c=data&type=1";
}
- (NSInteger)cacheTimeInSeconds {
    
    return 60 * 3;
}
@end
