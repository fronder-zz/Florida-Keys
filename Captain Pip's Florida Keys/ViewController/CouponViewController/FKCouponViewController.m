//
//  FKCouponViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 30.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponViewController.h"

@interface FKCouponViewController ()

@property (nonatomic, strong) NSString *shopID;

@end

@implementation FKCouponViewController

- (instancetype)init {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.shopID = SHOP_ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end
