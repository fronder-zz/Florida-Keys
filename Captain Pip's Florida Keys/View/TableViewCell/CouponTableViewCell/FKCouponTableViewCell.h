//
//  FKCouponTableViewCell.h
//  Florida Keys
//
//  Created by Hasan's Mac on 02.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FKCouponObject;

static NSString *CouponTableViewCellIdentifier = @"CouponTableViewCell";

@interface FKCouponTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;

@property (weak, nonatomic) FKCouponObject *coupon;

@end
