//
//  VenueMapViewController.h
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Venue;

@interface VenueMapViewController : UIViewController
@property (nonatomic, strong) Venue *venue;
@property (weak, nonatomic) IBOutlet MKMapView *venueMapView;
@end
