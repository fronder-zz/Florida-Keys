//
//  FKOfferViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 05.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKOfferViewController.h"
#import "AppDelegate.h"

@interface FKOfferViewController () {
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FKOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = APP_DELEGATE;
    
    [FKRequestManager requestSpecialOffer:^(id response) {
        if ([response[@"Result"] isEqualToString:@"Success"]) {
//            response[@"SpecialOffer"]
            
            NSString *urlString = [NSString stringWithFormat:@"%@%@/%@sploffer.html", API_BASE_URL, METHOD_OFFER_DETAILS, BASE_SHOP_ID];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        }
        
    } failure:^(id failure) {
        [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Server Error";
        hud.margin = 10.f;
        hud.yOffset = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:appDelegate.window animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideAllHUDsForView:appDelegate.window animated:YES];
}


@end
