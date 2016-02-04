//
//  FKCouponTableViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 31.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponTableViewController.h"
#import "FKCouponDetailsViewController.h"
#import "FKCouponViewController.h"
#import "FKCouponTableViewCell.h"
#import "FKCouponObject.h"

@interface FKCouponTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *couponsArray;

@end

@implementation FKCouponTableViewController

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.couponsArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FKCouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:CouponTableViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getTotalShopsCount];
}


#pragma mark - Helper

- (void)getTotalShopsCount {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [FKRequestManager requestNumberOfShops:^(id response) {
        if ([response[@"Result"] isEqualToString:@"Success"]) {
            if ([response[@"Keyresult"] isKindOfClass:[NSString class]] && [response[@"Keyresult"] intValue] == 0) {
                
            } else if ([response[@"Keyresult"] isKindOfClass:[NSString class]] && [response[@"Keyresult"] intValue] == 1) {
                
            } else
                [self getAvailableShops];
        }
        
        NSLog(@"Shops: %@", response);
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(id failure) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)getAvailableShops {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.couponsArray removeAllObjects];
    [FKRequestManager requestAvailableShops:^(id response) {
        NSArray *responseArray = response[@"CouponResult"];
        
        [self storeShopDetails:responseArray];
        
        NSArray *couponObjects = [responseArray valueForKeyPath:@"result"][0];
        for (NSArray *object in couponObjects) {
            FKCouponObject *coupon = [[FKCouponObject alloc] initWithArray:object];
            [self.couponsArray addObject:coupon];
        }
        
        [self.tableView reloadData];
        
        NSLog(@"Shops data: %@", response);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(id failure) {
        
        NSLog(@"Error: %@", failure);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)storeShopDetails:(NSArray *)data {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[data valueForKey:KEY_SHOP_ADDRESS][0] forKey:KEY_SHOP_ADDRESS];
    [defaults setObject:[data valueForKey:KEY_SHOP_LAT][0] forKey:KEY_SHOP_LAT];
    [defaults setObject:[data valueForKey:KEY_SHOP_LONG][0] forKey:KEY_SHOP_LONG];
    [defaults setObject:[data valueForKey:KEY_SHOP_NAME][0] forKey:KEY_SHOP_NAME];
    [defaults setObject:[data valueForKey:KEY_SHOP_PHONE][0] forKey:KEY_SHOP_PHONE];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FKCouponTableViewCell *cell = (FKCouponTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CouponTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[FKCouponTableViewCell alloc] init];
    }
    
    FKCouponObject *coupon = self.couponsArray[indexPath.row];
    [cell setCoupon:coupon];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 234;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FKCouponObject *couponObject = self.couponsArray[indexPath.row];
    FKCouponViewController *couponVC = (FKCouponViewController *)self.parentViewController;
    [couponVC showCouponObjectDetail:couponObject];
}



@end
