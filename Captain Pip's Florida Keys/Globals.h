//
//  Globals.h
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#ifndef Globals_h
#define Globals_h

// System
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_5_OR_LESS (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

// API
#define API_BASE_URL            @"http://www.milemarkercoupons.com"
#define API_COMMON_URL          @"http://www.milemarkercoupons.com/api/shop.php/service"

// Methods
#define METHOD_SHOP_DETAILS     @"/getshopdetails"
#define METHOD_CHECK_DEVICE     @"/checkdevice"
#define METHOD_ADD_USER         @"/addUser"

// Common
#ifdef CAPTAIN_PIPS_FLORIDA_KEYS
#define USER_ID                 @"userID"
#define SHOP_ID                 @"B0301"
#define SHOP_NAME               @"Captain Pip's Florida Keys"
#endif

// Keys
#define KEY_DEVICE_TOKEN        @"deviceToken"
#define KEY_USERNAME            @"fld_username"
#define KEY_EMAIL               @"fld_useremail"
#define KEY_DEVICE_TYPE         @"fld_devicetype"
#define KEY_DEVICE_ID           @"fld_deviceid"
#define KEY_SHOP_ID             @"fld_shopid"
#define KEY_USER_ID             @"fld_userid"

// Helper
#define APP_DELEGATE            (AppDelegate *)[UIApplication sharedApplication].delegate
#define ALERT(text, view)       [FKManager alertWithText:text inView:view]
#define DEVICE_ID               [UIDevice currentDevice].identifierForVendor.UUIDString
#define IMAGE(image)            [UIImage imageNamed:image]

static NSString * const kInternetConnectionDidChangeNotification = @"InternetConnectionDidChangeNotification";

#endif /* Globals_h */
