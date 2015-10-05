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
    //知乎服务每天新的推送时间为6点
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    NSDate *pastDay = [NSDate dateWithTimeIntervalSinceNow:-(number*24*60*60)];

    return [dft stringFromDate:pastDay];
}


@end
