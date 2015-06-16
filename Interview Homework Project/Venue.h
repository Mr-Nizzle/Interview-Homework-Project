//
//  Venue.h
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Venue : JSONModel

@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *ticket_link;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *pcode;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *tollfreephone;
@property (strong, nonatomic) NSArray *schedule;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;

@end
