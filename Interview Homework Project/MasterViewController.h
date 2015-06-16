//
//  MasterViewController.h
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Venue;
@protocol MasterViewControllerDelegate <NSObject>

@required

-(void)ipadMasterdidSelectVenue:(Venue *)venue;

@end

@interface MasterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *venuesTableView;
@property (assign) id<MasterViewControllerDelegate> delegate;
@end
