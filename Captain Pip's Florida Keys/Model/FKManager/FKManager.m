//
//  FKManager.m
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKManager.h"

@implementation FKManager

@synthesize reachable = _reachable;

+ (instancetype)sharedManager {
    static FKManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FKManager alloc] init];
        [_sharedManager setReachable:YES];
    });
    
    return _sharedManager;
}

+ (UINavigationController *)navigationControllerWithVC:(UIViewController *)vc {
    return [[UINavigationController alloc] initWithRootViewController:vc];
}

+ (void)alertWithText:(NSString *)text inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Warning";
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.yOffset = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

@end
