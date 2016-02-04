//
//  FKCouponTableViewCell.m
//  Florida Keys
//
//  Created by Hasan's Mac on 02.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponTableViewCell.h"
#import "FKCouponObject.h"

@implementation FKCouponTableViewCell

- (instancetype)init {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}


- (void)setCoupon:(FKCouponObject *)coupon {
    [self.mainImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_BASE_URL, coupon.imagePath]]];
    
    if (coupon.isAvailable) {
        self.subImageView.image = IMAGE(@"activate.png");
    } else {
        if (coupon.isSurveyAvailable) {
            if (coupon.isTimeAvailable) {
                self.subImageView.image = IMAGE(@"feedback.png");
            } else
                //TODO
                NSLog(@"TODO");
            self.subImageView.image = IMAGE(@"feedback.png");
        } else
            self.subImageView.image = IMAGE(@"circle.png");
    }
}


@end
