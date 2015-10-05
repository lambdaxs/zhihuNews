//
//  UIBarButtonItem+XSNaviItem.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XSNaviItem)

/** 将文字样式UIButton转换成UIBarButtonItem */
+ (UIBarButtonItem *)buttonWithTarget:(id)target action:(SEL)action forControlEvent:(UIControlEvents)controlEvent title:(NSString *)title;

/** 将图片样式UIButton转换成UIBarButtonItem */
+ (UIBarButtonItem *)buttonWithTarget:(id)target action:(SEL)action forControlEvent:(UIControlEvents)controlEvent image:(UIImage *)image selImage:(UIImage *)selImage;

@end
