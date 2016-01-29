//
//  FKRequestManager.m
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKRequestManager.h"

@implementation FKRequestManager

+ (instancetype)sharedManager {
    static FKRequestManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FKRequestManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
    });
    return _sharedManager;
}

+ (void)requestShopDetails:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@", API_COMMON_URL, METHOD_SHOP_DETAILS, METHOD_SHOPID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
