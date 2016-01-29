//
//  FKRequestManager.h
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FKRequestManager : AFHTTPSessionManager

+ (void)requestShopDetails:(void(^)(id response))success failure:(void(^)(id failure))failure;

@end
