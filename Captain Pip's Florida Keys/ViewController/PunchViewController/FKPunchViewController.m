//
//  FKPunchViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 31.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKPunchViewController.h"
#import <MapKit/MapKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#define KEY_FLD_ADDRESS         @"fld_address"
#define KEY_FLD_LOYALTY_ID      @"fld_loyaltyid"
#define KEY_FLD_LOYALTY_IMAGE   @"fld_loyaltyimage"
#define KEY_FLD_SHOP_LAT        @"fld_shoplat"
#define KEY_FLD_SHOP_LONG       @"fld_shoplng"
#define KEY_FLD_SHOP_NAME       @"fld_shopname"
#define KEY_FLD_SHOP_PHONE      @"fld_shopphoneno"
#define KEY_MAX_PUNCH           @"maximum_punch"
#define KEY_PUNCH_COUNT         @"punchcount"

@interface FKPunchViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *punchNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

typedef enum {
    kContentHideAll,
    kContentHide,
    kContentShow
} Content;

@implementation FKPunchViewController

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self UISet];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getPunch];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self showContent:kContentHideAll];
}

- (void)viewDidLayoutSubviews {
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 820)];
}


#pragma mark - Action

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

- (void)UISet {
    self.topLabel.font = [UIFont robotoBlackSized:20.0f];
    self.addressLabel.font = [UIFont robotoBlackSized:20.0f];
    self.punchNumberLabel.font = [UIFont robotoBlackSized:20.0f];
    self.phoneButton.titleLabel.font = [UIFont robotoBlackSized:20.0f];
}

- (void)showContent:(Content)content {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    switch (content) {
        case kContentShow:
            [self.topLabel setHidden:YES];
            [self.contentView setHidden:NO];
            break;
        case kContentHide:
            [self.topLabel setHidden:NO];
            [self.contentView setHidden:YES];
            break;
        case kContentHideAll:
            [self.topLabel setHidden:YES];
            [self.contentView setHidden:YES];
            break;
        default:
            break;
    }
}

- (void)getPunch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [FKRequestManager requestPunch:^(id response) {
        if ([response[@"Result"] isEqualToString:@"Success"]) {
            if ([response[@"approved"] isEqualToString:@"true"]) {
                NSArray *punchDetails = response[@"Image"];
                if ([response[@"Offer"] isEqualToString:@"Available"]) {
                    [self showContent:kContentShow];
                }
                else {
                    NSString *imageUrlString = [NSString stringWithFormat:@"%@/%@", API_BASE_URL, [punchDetails valueForKey:KEY_FLD_LOYALTY_IMAGE][0]];
                    
                    NSString *target = @".gif" ;
                    NSRange range = [imageUrlString rangeOfString:target options:NSCaseInsensitiveSearch];
                    if (range.location != NSNotFound) {
                        UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:imageUrlString]];
                        [self.mainImageView setImage:mygif];
                    }
                    else {
                        [self.mainImageView setImageWithURL:[NSURL URLWithString:imageUrlString]];
                    }
                    
                    NSString *punchCount = [punchDetails valueForKey:KEY_PUNCH_COUNT][0];
                    NSString *maxPunches = [punchDetails valueForKey:KEY_MAX_PUNCH][0];
                    if ([punchCount intValue] > 0) {
                        [self.starImageView setImage:IMAGE(@"starfull.png")];
                    } else {
                        [self.starImageView setImage:IMAGE(@"starempty.png")];
                    }
                    self.punchNumberLabel.text = [NSString stringWithFormat:@"%@ / %@", punchCount, maxPunches];
                    [self.phoneButton setTitle:[punchDetails valueForKey:KEY_FLD_SHOP_PHONE][0] forState:UIControlStateNormal];
                    self.addressLabel.text = [punchDetails valueForKey:KEY_FLD_ADDRESS][0];
                    
                    NSString *latitude = [punchDetails valueForKey:KEY_FLD_SHOP_LAT][0];
                    NSString *longitude = [punchDetails valueForKey:KEY_FLD_SHOP_LONG][0];
                    NSString *shopName = [punchDetails valueForKey:KEY_FLD_SHOP_NAME][0];
                    [self addAnnotationWithLatitude:latitude longitude:longitude name:shopName];
                    
                    [self showContent:kContentShow];
                }
            }
        } else if ([response[@"Result"] isEqualToString:@"Failed"]) {
            
        }
        
    } failure:^(id failure) {
        
    }];
}

- (void)hideViews {
    
}

- (void)addAnnotationWithLatitude:(NSString *)latitude longitude:(NSString *)longitude name:(NSString *)name {
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    annotation.title = name;
    
    [self.map addAnnotation:annotation];
    
    MKCoordinateRegion region = self.map.region;
    region.center = location;
    region.span.longitudeDelta = 0.001; // Bigger the value, closer the map view
    region.span.latitudeDelta = 0.001;
    [self.map setRegion:region animated:YES]; // Choose if you want animate or not
}


@end
