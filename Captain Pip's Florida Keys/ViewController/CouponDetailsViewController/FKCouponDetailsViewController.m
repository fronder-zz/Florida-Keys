//
//  FKCouponDetailsViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 03.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponDetailsViewController.h"
#import <MapKit/MapKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "FKCouponViewController.h"
#import "FKCouponObject.h"

@interface FKCouponDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;


@end

@implementation FKCouponDetailsViewController

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.facebookButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadView];
}

- (void)viewDidLayoutSubviews {
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 717)];
}

#pragma mark - Action

- (IBAction)backButtonClicked:(id)sender {
    FKCouponViewController *couponVC = (FKCouponViewController *)self.parentViewController;
    [couponVC setSelectedIndex:0 animated:YES];
}

- (IBAction)phoneButtonClicked:(id)sender {
    NSString *phoneNumber = self.phoneButton.titleLabel.text;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else {
        [[[UIAlertView alloc]initWithTitle:BASE_SHOP_NAME message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

- (IBAction)facebookButtonClicked:(id)sender {
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.mode = FBSDKShareDialogModeShareSheet;
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentTitle = [NSString stringWithFormat:@"%@!", BASE_SHOP_NAME];
    content.contentDescription = [NSString stringWithFormat:@"DOWNLOAD YOUR FREE %@ APP TODAY and enjoy tons of savings in the #FloridaKeys",BASE_SHOP_NAME];
    content.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/success.png", API_BASE_URL]];
    content.contentURL = [NSURL URLWithString:API_BASE_URL];
    
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
}


#pragma mark - Helper

- (void)reloadView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.addressLbl.text = [defaults objectForKey:KEY_SHOP_ADDRESS];
    
    NSString *title = [defaults objectForKey:KEY_SHOP_PHONE];
    [self.phoneButton setTitle:title forState:UIControlStateNormal];
    
    [self.mainImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_BASE_URL, self.coupon.imagePath]]];
    NSString *latitude = [defaults objectForKey:KEY_SHOP_LAT];
    NSString *longitude = [defaults objectForKey:KEY_SHOP_LONG];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    annotation.title = [defaults objectForKey:KEY_SHOP_NAME];
    
    [self.map addAnnotation:annotation];
    
    MKCoordinateRegion region = self.map.region;
    region.center = location;
    region.span.longitudeDelta = 0.001; // Bigger the value, closer the map view
    region.span.latitudeDelta = 0.001;
    [self.map setRegion:region animated:YES]; // Choose if you want animate or not
}


@end
