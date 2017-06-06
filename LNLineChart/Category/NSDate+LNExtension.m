//
//  NSDate+LNExtension.m
//  计算时间差
//
//  Created by Doris on 16/1/27.
//  Copyright © 2016年 Doris. All rights reserved.
//

#import "NSDate+LNExtension.h"

@implementation NSDate (LNExtension)
+ (NSString *)localDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

+ (NSString *)customLocalDate {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSS"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

+ (NSString *)timeFileName {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

+ (NSDate *)mylocalDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

+ (NSString *)yearMonthDayDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

+ (NSString *)dateStrWithDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = [NSTimeZone systemTimeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)stringToDateWithStr:(NSString *)dateStr
{
    static NSDateFormatter *dateStrFormatter;
    if(!dateStrFormatter){
        dateStrFormatter = [NSDateFormatter new];
        dateStrFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [dateStrFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *switchDate = [dateStrFormatter dateFromString:dateStr];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: switchDate];
    NSDate *localeDate = [switchDate dateByAddingTimeInterval:interval];
    
    return localeDate;
}

/*
- (NSDate *)getInternetDate
{
    
}
 */
@end
