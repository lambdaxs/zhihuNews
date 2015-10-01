//
//  NSString+XSDate.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/28.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "NSString+XSDate.h"

@implementation NSString (XSDate)

+ (NSString *)stringWithDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)stringWithToday{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    return destDateString;
}

+ (NSString *)getThePastDayWithNumber:(NSInteger)number
{
    //判断是否在早上6点前 在6点前返回

    NSDate *pastDay = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*number)];
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    return [dft stringFromDate:pastDay];;
}


@end
