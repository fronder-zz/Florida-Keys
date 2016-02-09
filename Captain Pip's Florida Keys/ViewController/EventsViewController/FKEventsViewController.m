//
//  FKEventsViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 06.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKEventsViewController.h"
#import "CKCalendarView.h"
#import "FKEventTableViewCell.h"
#import "FKEvent.h"

@interface FKEventsViewController () <CKCalendarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopLayout;

@property (weak, nonatomic) IBOutlet CKCalendarView *calendar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableSet *datesSet;
@property (nonatomic, strong) NSMutableArray *eventObjects;
@property (nonatomic, strong) NSMutableArray *events;

@end

@implementation FKEventsViewController

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datesSet = [[NSMutableSet alloc] initWithCapacity:0];
    self.eventObjects = [[NSMutableArray alloc] initWithCapacity:0];
    self.events = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.calendar.delegate = self;
    self.calendar.onlyShowCurrentMonth = NO;
    self.calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FKEventTableViewCell class]) bundle:nil] forCellReuseIdentifier:EventCellIdentifier];
    
    [self getEvents];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Our Events";
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}


#pragma mark - Helper

- (void)getEvents {
    [FKRequestManager requestEvents:^(id response) {
        if ([response[@"Result"] isEqualToString:@"Success"]) {
            NSArray *events = response[@"Event_Details"];
            [events enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *eventDetails = obj;
                FKEvent *event = [[FKEvent alloc] initWithDictionary:eventDetails];
                [self.eventObjects addObject:event];
                [self.datesSet addObject:event.eventDate];
            }];
        }
    } failure:^(id failure) {}];
}

- (NSArray *)eventsFromDate:(NSString *)dateString {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self.eventObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FKEvent *event = (FKEvent *)obj;
        if ([event.eventDate isEqualToString:dateString]) {
            [array addObject:event];
        }
    }];
    
    return array;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FKEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventCellIdentifier forIndexPath:indexPath];
    
    FKEvent *eventObject = self.events[indexPath.row];
    cell.eventTitleLabel.text = eventObject.eventTitle;
    cell.eventDescriptionLabel.text = eventObject.eventDescription;
    cell.eventTimeLabel.text = eventObject.eventTime;
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    if ([self.datesSet containsObject:dateString]) {
        dateItem.textColor = [UIColor whiteColor];
        dateItem.backgroundColor =[UIColor colorWithRed:3/255.0 green:111/255.0 blue:86/255.0 alpha:1];
    }
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    [self.events removeAllObjects];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    if ([self.datesSet containsObject:dateString]) {
        [self.events addObjectsFromArray:[self eventsFromDate:dateString]];
        [self.tableView reloadData];
    }
}

//- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
//    NSLog(@"didlayout frame: %@", NSStringFromCGRect(frame));
//    CGFloat height = frame.size.height;
//    if (height > 330) {
//        self.tableViewTopLayout.constant = 63;
//    } else
//        self.tableViewTopLayout.constant = 11;
//}


@end
