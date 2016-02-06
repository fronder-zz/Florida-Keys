//
//  FKFAQViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 06.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKFAQViewController.h"

@interface FKFAQViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *_progressHud;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation FKFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@faq.html", API_BASE_URL, METHOD_OFFER_DETAILS, BASE_SHOP_ID];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"FAQ";
    self.navigationController.navigationBarHidden = NO;
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
