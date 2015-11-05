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

#warning mark - 知乎的服务器更新在早上7点
+ (NSString *)getThePastDayWithNumber:(NSInteger)number
{
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    NSDate *pastDay = [self isUpdate] ? [NSDate dateWithTimeIntervalSinceNow:-(number*24*3600)]: [NSDate dateWithTimeIntervalSinceNow:-(number+1)*24*3600];
    
    return [dft stringFromDate:pastDay];
}

/** 判断是否更新了故事 */
+ (BOOL)isUpdate
{
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    [dft setDateFormat:@"yyyyMMdd"];
    
    NSString *yesterdayStr = [dft stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-(24*3600)]];
    NSString *pastSevenhourStr = [dft stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-(7*3600)]];
    
    return [yesterdayStr isEqualToString:pastSevenhourStr] ? NO: YES;
}

+ (NSString *)dateStrForHeadViewWith:(NSString *)dateStr
{
    NSRange monthRange = [@"19990203" rangeOfString:@"02"];
    NSString *monthStr = [dateStr substringWithRange:monthRange];
    NSRange dayRange = [@"19990203" rangeOfString:@"03"];
    NSString *dayStr = [dateStr substringWithRange:dayRange];
    
    //字符串转日期
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMdd";
    NSDate *curDate = [df dateFromString:dateStr];
    //日历操作判断星期
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:curDate];
    NSInteger weekNum = [dayComponents weekday];
    NSArray *weekArr = @[@"error",@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    return [NSString stringWithFormat:@" %@月%@日 %@",monthStr,dayStr,weekArr[weekNum]];
}


@end
