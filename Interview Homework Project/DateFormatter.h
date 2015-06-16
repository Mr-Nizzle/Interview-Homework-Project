//
//  DateFormatter.h
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject
-(NSString *)formattedStringForScheduleWithStartDateString:(NSString *)startDateString andEndDateString:(NSString *)endDateString;
@end
