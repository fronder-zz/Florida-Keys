//
//  FKEvent.m
//  Florida Keys
//
//  Created by Hasan's Mac on 07.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKEvent.h"

@implementation FKEvent

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.eventTitle = dictionary[KEY_EVENT_TITLE];
        self.eventDescription = dictionary[KEY_EVENT_DESCRIPTION];
        self.eventDate = dictionary[KEY_EVENT_DATE];
        self.eventTime = dictionary[KEY_EVENT_TIME];
        self.eventID = dictionary[KEY_EVENT_ID];
    }
    return self;
}

@end
