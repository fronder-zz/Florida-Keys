//
//  Globals.h
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#ifndef Globals_h
#define Globals_h

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


static NSString * const kInternetConnectionDidChangeNotification = @"InternetConnectionDidChangeNotification";

#endif /* Globals_h */
