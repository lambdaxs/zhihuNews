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
    //判断是否在今天早上6点前 0---6点前返回昨天x

    NSDate *pastDay = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*number)];
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    return [dft stringFromDate:pastDay];
}

//+ (NSString *)getThePastDayWithNumber:(NSUInteger)number
//{
//    //判断是否在今天早上6点前 0---6点前返回昨天
//    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
//    [dft setDateFormat:@"yyyyMMdd"];
//    NSDate *pastDay;
//    if ([self isPastSixHours]) {
//        pastDay = [NSDate dateWithTimeIntervalSinceNow:-(number*24*60*60)];
//    }else{
//        pastDay = [NSDate date];
//    }
//    
//    return [dft stringFromDate:pastDay];
//}

+ (BOOL)isPastSixHours
{
    NSDate *yesterDay = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDate *sixHour = [NSDate dateWithTimeIntervalSinceNow:-(6*60*60)];
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    
    NSString *yesterdayStr = [dft stringFromDate:yesterDay];
    NSString *sixhourStr = [dft stringFromDate:sixHour];
    
    if ([yesterdayStr isEqualToString:sixhourStr]) {
        return NO;
    }else{
        return YES;
    }
}


@end
