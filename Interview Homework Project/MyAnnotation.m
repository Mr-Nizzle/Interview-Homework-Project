//
//  MyAnnotation.m
//  MejorandoLaCiudad
//
//  Created by Ricardo Guillen on 5/31/15.
//  Copyright (c) 2015 NizzleDev. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    coordinate=coord;
    return self;
}

-(CLLocationCoordinate2D)coord
{
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

@end
