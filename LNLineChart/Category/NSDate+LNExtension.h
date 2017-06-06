//
//  NSDate+LNExtension.h
//  计算时间差
//
//  Created by Doris on 16/1/27.
//  Copyright © 2016年 Doris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LNExtension)
+ (NSString *)localDate;
+ (NSDate *)mylocalDate;
+ (NSString *)yearMonthDayDate;
+ (NSString *)dateStrWithDate:(NSDate *)date;
+ (NSString *)customLocalDate;
+ (NSDate *)stringToDateWithStr:(NSString *)str;
+ (NSString *)timeFileName;
@end
