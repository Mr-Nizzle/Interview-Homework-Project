//
//  DetailViewController.h
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Venue;
@interface DetailViewController : UIViewController
@property (nonatomic, strong) Venue *venue;
@property (strong, nonatomic) IBOutlet UIView *schedulesHeaderView;
@property (weak, nonatomic) IBOutlet UIView *venueHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *venueImageView;
@property (weak, nonatomic) IBOutlet UITableView *venueSchedulesTableView;
@end
