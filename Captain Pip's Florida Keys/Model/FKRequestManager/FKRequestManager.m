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
    NSString *URLString = [NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_SHOP_DETAILS, BASE_SHOP_ID];
    
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

+ (void)requestNumberOfShops:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_SHOP_NUMBER, BASE_SHOP_ID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestAvailableShops:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_ID];
    NSAssert(userid, @"There is no USER ID");
    NSString *URLString =[NSString stringWithFormat:API_SHOPS_URL , BASE_SHOP_ID, userid];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestPunch:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_ID];
    NSAssert(userid, @"There is no USER ID");
    NSString *URLString =[NSString stringWithFormat:@"%@%@/%@/%@", API_COMMON_URL, METHOD_PUNCH, BASE_SHOP_ID, userid];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestSpecialOffer:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString =[NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_SPECIAL_OFFER, BASE_SHOP_ID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestSpecial:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_SPECIAL, BASE_SHOP_ID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestPolice:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_POLICE, BASE_SHOP_ID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)requestEvents:(void(^)(id response))success failure:(void(^)(id failure))failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@/%@", API_COMMON_URL, METHOD_EVENTS, BASE_SHOP_ID];
    
    [[[self class] sharedManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


// POST
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
