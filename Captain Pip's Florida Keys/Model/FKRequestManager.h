//
//  FKRequestManager.h
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FKRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

// Method for obtaining shop details
+ (void)requestShopDetails:(void(^)(id response))success failure:(void(^)(id failure))failure;

// 
+ (void)requestCheckDeviceWithURLString:(NSString *)URLString withBlock:(void(^)(id response))success failure:(void(^)(id failure))failure;

// Method for registering user to the server
+ (void)requestAddUserWithParameters:(id)parameters withBlock:(void(^)(id response))success failure:(void(^)(id failure))failure;

@end
