//
//  FKOfferViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 05.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKOfferViewController.h"
#import "AppDelegate.h"

@interface FKOfferViewController () <MBProgressHUDDelegate> {
    AppDelegate *_appDelegate;
    MBProgressHUD *_progressHud;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FKOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = APP_DELEGATE;
    
    [FKRequestManager requestSpecialOffer:^(id response) {
        if ([response[@"Result"] isEqualToString:@"Success"]) {
            NSArray *speccialOfferArray = response[@"SpecialOffer"];
            NSString *specialID = [speccialOfferArray valueForKey:KEY_SPECIAL_ID][0];
            [[NSUserDefaults standardUserDefaults] setObject:specialID forKey:KEY_OFFER_ID];
            
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Our special offer";
    self.navigationController.navigationBarHidden = NO;
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
    _progressHud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.webView addSubview:_progressHud];
    _progressHud.delegate = self;
    _progressHud.labelText = @"Loading";
    [_progressHud show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressHud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressHud hide:YES];
}


@end
