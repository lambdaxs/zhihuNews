//
//  XSCellHeadView.h
//  zhiHu2.0
//
//  Created by xiaos on 15/10/1.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XSCellHeadViewHeight 35.0f

@interface XSCellHeadView : UIView

@property (nonatomic,copy) NSString *dateStr;

+ (instancetype)cellHeadViewWithFrame:(CGRect)frame;

@end
