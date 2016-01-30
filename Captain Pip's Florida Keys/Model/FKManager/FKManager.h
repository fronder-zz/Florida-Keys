//
//  FKManager.h
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKManager : NSObject

@property (nonatomic, assign, getter=isReachable) BOOL reachable;

+ (instancetype)sharedManager;
+ (UINavigationController *)navigationControllerWithVC:(UIViewController *)vc;
+ (void)alertWithText:(NSString *)text inView:(UIView *)view;

@end
