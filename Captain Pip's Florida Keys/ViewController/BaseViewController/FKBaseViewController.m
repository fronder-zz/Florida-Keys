//
//  FKBaseViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 04.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKBaseViewController.h"

@interface FKBaseViewController ()

@end

@implementation FKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:IMAGE(@"WOOD-BACKGROUND-LOW-RES.jpg")]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


@end
