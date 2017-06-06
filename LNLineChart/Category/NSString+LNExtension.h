//
//  NSString+LNExtension.h
//  pianoteiphone
//
//  Created by Doris on 16/6/23.
//  Copyright © 2016年 阎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LNExtension)
+(NSString *)translationArabicNum:(NSInteger)arabicNum;
- (NSString *)md5Str;

+ (NSString *)getYearMonthDayWithDateStr:(NSString *)dateStr;

+ (NSString *)platform;

+ (NSString *)sysMachine;

+ (NSString *)systemVersion;
@end
