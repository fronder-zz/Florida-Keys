//
//  FKDateTableViewCell.h
//  Florida Keys
//
//  Created by Hasan's Mac on 06.02.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const EventCellIdentifier = @"EventCellIdentifier";

@interface FKEventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;


@end
