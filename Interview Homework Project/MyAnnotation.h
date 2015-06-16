//
//  MyAnnotation.h
//  MejorandoLaCiudad
//
//  Created by Ricardo Guillen on 5/31/15.
//  Copyright (c) 2015 NizzleDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D coordinate;
    
}
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
