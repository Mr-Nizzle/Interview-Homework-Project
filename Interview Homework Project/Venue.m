//
//  Venue.m
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "Venue.h"

@implementation Venue

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"venueID",
                                                       @"ticket_link" : @"ticketLink",
                                                       @"image_url" : @"imageURL",
                                                       @"tollfreephone" : @"tollFreePhone" 
                                                       }];
}

@end
