//
//  NSDictionary+FKDictionary.m
//  Florida Keys
//
//  Created by Hasan's Mac on 30.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "NSDictionary+FKDictionary.h"

@implementation NSDictionary (FKDictionary)

- (NSString *)stringDescription {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (!jsonData) {
        return nil;
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
