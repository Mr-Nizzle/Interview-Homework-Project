//
//  DetailViewController.h
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Venue;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
@property (nonatomic, strong) Venue *venue;
@property (strong, nonatomic) IBOutlet UIView *schedulesHeaderView;
@property (weak, nonatomic) IBOutlet UIView *venueHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *venueImageView;
@property (weak, nonatomic) IBOutlet UITableView *venueSchedulesTableView;
@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *ticketButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
- (IBAction)openTicket:(id)sender;
- (IBAction)callPhone:(id)sender;
- (IBAction)showLocation:(id)sender;
@end
