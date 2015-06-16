//
//  VenueTableViewCell.h
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *venueScheduleLabel;

@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueAddressLabel;
@end
