//
//  Venue.m
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "Venue.h"

@implementation Venue


- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.zip = dictionary[@"zip"];
        self.phone = dictionary[@"phone"];
        self.ticket_link = dictionary[@"ticket_link"];
        self.state = dictionary[@"state"];
        self.pcode = dictionary[@"pcode"];
        self.city = dictionary[@"city"];
        self.venue_id = dictionary[@"id"];
        self.tollfreephone = dictionary[@"tollfreephone"];
        self.schedule = dictionary[@"schedule"];
        self.address = dictionary[@"address"];
        self.image_url = dictionary[@"image_url"];
        self.name = dictionary[@"name"];
        self.longitude = dictionary[@"longitude"];
        self.latitude = dictionary[@"latitude"];
    }
    return self;
}

@end
