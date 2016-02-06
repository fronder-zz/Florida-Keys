//
//  FKSettingsViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 06.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKSettingsViewController.h"

@interface FKSettingsViewController ()

@end

@implementation FKSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Settings";
    self.navigationController.navigationBarHidden = NO;
}

@end
