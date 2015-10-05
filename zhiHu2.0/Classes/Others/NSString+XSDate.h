//
//  NSString+XSDate.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/28.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XSDate)

/** 根据日期返回对应字符串 */
+ (NSString *)stringWithDate:(NSDate *)date;

/** 返回今天日期的字符串 */
+ (NSString *)stringWithToday;

/** 返回前n天的日期Str */
+ (NSString *)getThePastDayWithNumber:(NSInteger)number;

@end
