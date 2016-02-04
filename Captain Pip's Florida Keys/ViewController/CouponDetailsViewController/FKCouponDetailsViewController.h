//
//  FKCouponDetailsViewController.h
//  Florida Keys
//
//  Created by Hasan's Mac on 03.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKBaseViewController.h"

@class FKCouponObject;

@interface FKCouponDetailsViewController : FKBaseViewController

@property (nonatomic, strong) FKCouponObject *coupon;

@end

