//
//  FKCouponObject.m
//  Florida Keys
//
//  Created by Hasan's Mac on 03.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponObject.h"

@implementation FKCouponObject

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.ID = [array valueForKey:@"fld_couponid"];
        self.imagePath = [array valueForKey:@"fld_couponimage"];
        self.priority = [[array valueForKey:@"fld_priority"] integerValue];
        
        if ([[array valueForKey:@"CouponStatus"] isEqualToString:@"Available"]) {
            self.available = YES;
        } else
            self.available = NO;
        if ([[array valueForKey:@"CouponStatus"] isEqualToString:@"Survey Available"]) {
            self.surveyAvailable = YES;
        } else
            self.surveyAvailable = NO;
        if ([[array valueForKey:@"TimeResult"] isEqualToString:@"Time Not Available"]) {
            self.timeAvailable = NO;
        } else
            self.timeAvailable = YES;
    }
    return self;
}

@end
