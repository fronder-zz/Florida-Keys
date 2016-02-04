//
//  FKCouponDetailsViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 03.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponDetailsViewController.h"
#import <MapKit/MapKit.h>

#import "FKCouponViewController.h"
#import "FKCouponObject.h"

@interface FKCouponDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (nonatomic, strong) FKCouponObject *coupon;



@end

@implementation FKCouponDetailsViewController

- (instancetype)initWithCouponObject:(FKCouponObject *)couponObject {
    self = [self init];
    if (self) {
        self.coupon = couponObject;
    }
    return self;
}

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 717)];
    self.facebookButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewDidLayoutSubviews {
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 717)];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 717)];
}

#pragma mark - Action

- (IBAction)backButtonClicked:(id)sender {
    FKCouponViewController *couponVC = (FKCouponViewController *)self.parentViewController;
    [couponVC setSelectedIndex:0 animated:YES];
}

- (IBAction)phoneButtonClicked:(id)sender {
}

- (IBAction)facebookButtonClicked:(id)sender {
}


@end
