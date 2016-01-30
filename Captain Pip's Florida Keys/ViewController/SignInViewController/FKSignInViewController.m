//
//  FKSignInViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKSignInViewController.h"
#import "FKCouponViewController.h"
#import "AppDelegate.h"

@interface FKSignInViewController ()

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


#pragma mark - Action

- (IBAction)enterButtonClicked:(id)sender {
    if (![FKManager sharedManager].isReachable) {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];return;
    }
    if (self.usernameTF.text.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if (self.emailTF.text.length > 0) {
            if (![self.emailTF.text isValidEmail]) {
                [[[UIAlertView alloc] initWithTitle:SHOP_NAME message:@"Please enter valid Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
                return;
            }
        }
        
        NSDictionary *parameters = @{KEY_EMAIL: self.emailTF.text > 0 ? self.emailTF.text : @"",
                                     KEY_USERNAME: self.usernameTF.text,
                                     KEY_DEVICE_TYPE: @"2",
                                     KEY_DEVICE_ID: DEVICE_ID,
                                     KEY_SHOP_ID: SHOP_ID};
        
        [FKRequestManager requestAddUserWithParameters:parameters withBlock:^(id response) {
            if ([response[@"Result"] isEqualToString:@"Success"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:parameters[KEY_USER_ID] forKey:KEY_USER_ID];
                [defaults setObject:parameters[KEY_USERNAME] forKey:KEY_USERNAME];
                [defaults setObject:parameters[KEY_EMAIL] forKey:KEY_EMAIL];
                
                [defaults synchronize];
                
                FKCouponViewController *couponVC = [[FKCouponViewController alloc] init];
                AppDelegate *appDelegate = APP_DELEGATE;
                [appDelegate.window setRootViewController:couponVC];
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




@end
