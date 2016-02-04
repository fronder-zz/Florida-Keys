//
//  FKCouponObject.h
//  Florida Keys
//
//  Created by Hasan's Mac on 03.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKCouponObject : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) UIImage *imagePath;

@property (nonatomic, assign, getter=isAvailable) BOOL available;
@property (nonatomic, assign, getter=isSurveyAvailable) BOOL surveyAvailable;
@property (nonatomic, assign, getter=isTimeAvailable) BOOL timeAvailable;

@property (nonatomic, assign) NSInteger priority;

- (instancetype)initWithArray:(NSArray *)array;

@end
