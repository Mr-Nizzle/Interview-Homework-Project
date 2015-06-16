//
//  DateFormatter.m
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

-(NSString *)formattedStringForScheduleWithStartDateString:(NSString *)startDateString andEndDateString:(NSString *)endDateString{
    NSDateFormatter *dateFormatterGMT = [[NSDateFormatter alloc] init];
    [dateFormatterGMT setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDateFormatter *dateFormatterHuman = [[NSDateFormatter alloc] init];
    [dateFormatterHuman setDateFormat:@"EEEE dd 'from' hh:mma"];
    [dateFormatterHuman setAMSymbol:@"am"];
    [dateFormatterHuman setPMSymbol:@"pm"];
    NSDateFormatter *dateFormatterHumanTo = [[NSDateFormatter alloc] init];
    [dateFormatterHumanTo setDateFormat:@"'to' hh:mma"];
    [dateFormatterHumanTo setAMSymbol:@"am"];
    [dateFormatterHumanTo setPMSymbol:@"pm"];
    NSDate *dateFrom = [dateFormatterGMT dateFromString:startDateString];
    NSDate *dateTo = [dateFormatterGMT dateFromString:endDateString];
    NSString *formattedDateStringFrom = [dateFormatterHuman stringFromDate:dateFrom];
    NSString *formattedDateStringTo = [dateFormatterHumanTo stringFromDate:dateTo];
    NSString *returnString = [NSString stringWithFormat:@"%@ %@", formattedDateStringFrom, formattedDateStringTo];
    return returnString;
}

@end
