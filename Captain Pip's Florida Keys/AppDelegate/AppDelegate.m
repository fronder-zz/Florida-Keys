//
//  AppDelegate.m
//  Captain Pip's Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "AppDelegate.h"
#import "FKLaunchViewController.h"
#import "FKCouponViewController.h"
#import "FKSignInViewController.h"

@interface AppDelegate () {
    NSString *_deviceTokenStr;
    BOOL _userSigned;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FKRequestManager sharedManager];
    [self addNotificationObservers];
    
    [self loadSplashScreen];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    
}
#endif

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    _deviceTokenStr =[NSString stringWithFormat:@"%@",deviceToken];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"< >"];
    _deviceTokenStr = [[_deviceTokenStr componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
    
    NSLog(@"My token is: %@",  _deviceTokenStr);
    NSUserDefaults *userValue = [NSUserDefaults standardUserDefaults];
    [userValue setObject:_deviceTokenStr forKey:@"DEVICE_TOKEN"];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Helper

- (void)addNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(internetConnectionStatusDidChange:) name:kInternetConnectionDidChangeNotification object:nil];
}

- (void)internetConnectionStatusDidChange:(NSNotification *)notification {
    if ([notification.object boolValue] == YES) {
        NSLog(@"Reachable");
        if (!_userSigned) {
            [self loadSplashScreen];
        }
    }
}

- (void)loadSplashScreen {
    if (![FKManager sharedManager].isReachable) {
        _userSigned = NO;
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];return;
    }
    _userSigned = YES;
    [FKRequestManager requestShopDetails:^(id response) {
        _userSigned = YES;
        NSLog(@"success: %@", response);
        if ([response[@"Result"] isEqualToString:@"Success"]) {
            NSString *imageName = [response[@"Shopdetails"] valueForKey:@"fld_splashimg"][0];
            NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",API_BASE_URL, imageName];
            
            FKLaunchViewController *launchVC = [[FKLaunchViewController alloc] initWithImageUrl:imageUrl];
            [self.window setRootViewController:launchVC];
            
            [self signIn];
        }
    } failure:^(id failure) {
        NSLog(@"failure: %@", failure);
    }];
}

- (void)signIn {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_ID];
    if (userID) {
        [self.window setRootViewController:[FKManager navigationControllerWithVC:[[FKCouponViewController alloc] init]]];
    }
    else {
        if (![FKManager sharedManager].isReachable) {
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];return;
        }
        NSString *deviceId = [UIDevice currentDevice].identifierForVendor.UUIDString;
        
        NSString *urlString =[NSString stringWithFormat:@"%@%@/%@/%@/%@/2", API_COMMON_URL, METHOD_CHECK_DEVICE, deviceId, _deviceTokenStr, SHOP_ID];
        
        [FKRequestManager requestCheckDeviceWithURLString:urlString withBlock:^(id response) {
            NSLog(@"success: %@", response);
            if ([response[@"Result"] isEqualToString:@"Success"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[response[@"Shopdetails"] valueForKey:KEY_USER_ID][0] forKey:KEY_USER_ID];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.window setRootViewController:[FKManager navigationControllerWithVC:[[FKCouponViewController alloc] init]]];
            }
            else {
                FKSignInViewController *signInVC = [[FKSignInViewController alloc] init];
                [self.window setRootViewController:signInVC];
            }
        } failure:^(id failure) {
            NSLog(@"failure: %@", failure);
        }];
    }
}


@end
