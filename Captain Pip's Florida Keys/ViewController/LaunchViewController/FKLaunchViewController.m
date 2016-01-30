//
//  FKLaunchViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 29.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKLaunchViewController.h"

@interface FKLaunchViewController () {
    NSString *_imageUrlString;
}

@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;

@end

@implementation FKLaunchViewController

#pragma mark - Lyfecycle

- (instancetype)initWithImageUrl:(NSString *)imageURL {
    self = [self init];
    if (self) {
        _imageUrlString = imageURL;
    }
    return self;
}

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.launchImageView setImageWithURL:[NSURL URLWithString:_imageUrlString]];
}



@end



