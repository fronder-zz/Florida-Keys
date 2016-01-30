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
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"No Internet Connection");
                    [[FKManager sharedManager] setReachable:NO];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kInternetConnectionDidChangeNotification object:@(NO)];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WIFI");
                    [[FKManager sharedManager] setReachable:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kInternetConnectionDidChangeNotification object:@(YES)];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G");
                    [[FKManager sharedManager] setReachable:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kInternetConnectionDidChangeNotification object:@(YES)];
                    break;
                default:
                    NSLog(@"Unkown network status");
                    break;
            }
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return _sharedManager;
}

+ (void)requestShopDetails:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_SHOP_DETAILS, SHOP_ID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestCheckDeviceWithURLString:(NSString *)URLString withBlock:(void(^)(id response))success failure:(void(^)(id failure))failure {
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestAddUserWithParameters:(id)parameters withBlock:(void(^)(id response))success failure:(void(^)(id failure))failure {
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", API_COMMON_URL, METHOD_ADD_USER];
    
    FKRequestManager *manager = [[self class] sharedManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
