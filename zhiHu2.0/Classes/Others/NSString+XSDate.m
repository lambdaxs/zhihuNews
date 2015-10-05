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
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)stringWithToday{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    return destDateString;
}

+ (NSString *)getThePastDayWithNumber:(NSInteger)number
{
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    NSDate *pastDay;
    
    if ([self isPastSixHours]) {
        //超过6点正常返回值
        pastDay = [NSDate dateWithTimeIntervalSinceNow:-(number*24*3600)];
    }else{
        //0---6点跳着返回值
        pastDay = [NSDate dateWithTimeIntervalSinceNow:-(number++)*24*3600];
    }

    return [dft stringFromDate:pastDay];
}

/** 判断是否处在一天的0----6点 */
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
