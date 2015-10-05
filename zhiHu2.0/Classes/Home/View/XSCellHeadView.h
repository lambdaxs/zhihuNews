//
//  XSCellHeadView.h
//  zhiHu2.0
//
//  Created by xiaos on 15/10/1.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>
/** cell头视图高度 */
#define CELL_HEAD_HEIGHT 35.0f

@interface XSCellHeadView : UIView

/** 要传入的日期字符串 */
@property (nonatomic,copy) NSString *dateStr;

/** 初始化类方法 */
+ (instancetype)cellHeadViewWithFrame:(CGRect)frame;

@end
