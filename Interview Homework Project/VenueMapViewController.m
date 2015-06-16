//
//  VenueMapViewController.m
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "VenueMapViewController.h"
#import "Venue.h"
#import "MyAnnotation.h"

@interface VenueMapViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation VenueMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    if(([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.locationManager startUpdatingLocation];
        _venueMapView.showsUserLocation = YES;
        
    }
    [self setMapPin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMapPin{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [_venue.latitude floatValue];
    coordinate.longitude = [_venue.longitude floatValue];
    MyAnnotation *myPin = [[MyAnnotation alloc] initWithCoordinate:coordinate];
    [self.venueMapView addAnnotation:myPin];
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    region.center.latitude = [_venue.latitude floatValue];
    region.center.longitude = [_venue.longitude floatValue];
    span.latitudeDelta = 0.0005;
    span.longitudeDelta = 0.0005;
    region.span = span;
    [self.venueMapView setRegion:region animated:TRUE];
}

@end
