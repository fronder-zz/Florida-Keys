//
//  FKEvent.h
//  Florida Keys
//
//  Created by Hasan's Mac on 07.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_EVENT_TITLE         @"fld_eventname"
#define KEY_EVENT_DESCRIPTION   @"fld_desp"
#define KEY_EVENT_DATE          @"fld_eventdate"
#define KEY_EVENT_TIME          @"fld_eventtime"
#define KEY_EVENT_ID            @"fld_id"

@interface FKEvent : NSObject

@property (nonatomic, strong) NSString *eventTitle;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventDate;
@property (nonatomic, strong) NSString *eventTime;
@property (nonatomic, strong) NSString *eventID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
