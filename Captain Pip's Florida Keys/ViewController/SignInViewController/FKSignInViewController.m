//
//  FKSignInViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKSignInViewController.h"
#import "FKCouponViewController.h"
#import "FKCouponTableViewController.h"
#import "FKPunchViewController.h"
#import "AppDelegate.h"

#define kLayoutMargin 80

@interface FKSignInViewController () <FKTabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout2;

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;

@end

@implementation FKSignInViewController


#pragma mark - Action

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark - Action

- (IBAction)enterButtonClicked:(id)sender {
    if (![FKManager sharedManager].isReachable) {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];return;
    }
    if (self.usernameTF.text.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if (self.emailTF.text.length > 0) {
            if (![self.emailTF.text isValidEmail]) {
                [[[UIAlertView alloc] initWithTitle:BASE_SHOP_NAME message:@"Please enter valid Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
                return;
            }
        }
        
        NSDictionary *parameters = @{KEY_EMAIL: self.emailTF.text > 0 ? self.emailTF.text : @"",
                                     KEY_USERNAME: self.usernameTF.text,
                                     KEY_DEVICE_TYPE: @"2",
                                     KEY_DEVICE_ID: DEVICE_ID,
                                     KEY_SHOP_ID: BASE_SHOP_ID};
        
        [FKRequestManager requestAddUserWithParameters:parameters withBlock:^(id response) {
            if ([response[@"Result"] isEqualToString:@"Success"]) {
                if ([response[@"UserDetails"] isKindOfClass:[NSString class]] && [response[@"UserDetails"] isEqualToString:@"Email Already exists"]) {
                    [[[UIAlertView alloc] initWithTitle:BASE_SHOP_NAME message:@"Email already exists" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                } else {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:response[KEY_USER_ID] forKey:KEY_USER_ID];
                    [defaults setObject:response[KEY_USERNAME] forKey:KEY_USERNAME];
                    [defaults setObject:response[KEY_EMAIL] forKey:KEY_EMAIL];
                    
                    [defaults synchronize];
                    
                    [self gotoCouponViewController];
                }
            } else {
                [[[UIAlertView alloc] initWithTitle:BASE_SHOP_NAME message:@"Unable to Sign in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
            
            [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
        } failure:^(id failure) {

           [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
        }];
    } else {
        [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
        
        ALERT(@"Please enter User Name", self.view);
    }
}

- (void)gotoCouponViewController {
    FKCouponTableViewController *couponTableViewVC = [[FKCouponTableViewController alloc] init]; //WithFrame:self.bodyView.frame];
    couponTableViewVC.title = @"Coupon";
    FKPunchViewController *punchVC = [[FKPunchViewController alloc] init]; //WithFrame:self.bodyView.frame];
    punchVC.title = @"Punch";
    
    NSArray *viewControllers = @[couponTableViewVC, punchVC];
    
    AppDelegate *appDelegate = APP_DELEGATE;
    
    FKCouponViewController *couponVC = [[FKCouponViewController alloc] init];
    [couponVC setViewControllers:viewControllers];
    
    [appDelegate.window setRootViewController:couponVC];
}

- (void)keyboardWillShow {
    if (self.topLayout.constant > 0) {
        [UIView animateWithDuration:3.0 animations:^{
            self.topLayout.constant -= kLayoutMargin;
            self.topLayout2.constant -= kLayoutMargin;
        }];
    }
}

- (void)keyboardWillHide {
    if (self.topLayout.constant < 0) {
        [UIView animateWithDuration:3.0 animations:^{
            self.topLayout.constant += kLayoutMargin;
            self.topLayout2.constant += kLayoutMargin;
        }];
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



@end
