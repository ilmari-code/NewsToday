//
//  LoadHomeDataApi.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/7/20.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "LoadHomeDataApi.h"

@implementation LoadHomeDataApi
{
    NSDictionary *_dict;
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
//        _dict = dict;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (NSString *)requestUrl {
    return @"District/province.html?mode=app";
}

- (NSInteger)cacheTimeInSeconds {
    
    return 60 * 3;
}

@end
