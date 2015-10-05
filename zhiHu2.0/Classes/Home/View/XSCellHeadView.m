//
//  XSCellHeadView.m
//  zhiHu2.0
//
//  Created by xiaos on 15/10/1.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSCellHeadView.h"

@interface XSCellHeadView ()

@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation XSCellHeadView

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width, self.height)];
        [_dateLabel setTextColor:[UIColor whiteColor]];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

+ (instancetype)cellHeadViewWithFrame:(CGRect)frame
{
    XSCellHeadView *headView = [[self alloc] init];
    headView.backgroundColor = RGB(1, 120, 216);//知乎蓝
    headView.frame = frame;
    return headView;
}

#pragma mark - 处理字符串业务
-(void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    
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
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@月%@日%@",monthStr,dayStr,weekArr[weekNum]];
}

@end
