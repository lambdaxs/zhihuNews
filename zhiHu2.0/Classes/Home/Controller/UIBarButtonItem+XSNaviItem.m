//
//  UIBarButtonItem+XSNaviItem.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "UIBarButtonItem+XSNaviItem.h"

@implementation UIBarButtonItem (XSNaviItem)

+ (UIBarButtonItem *)buttonWithTarget:(id)target action:(SEL)action forControlEvent:(UIControlEvents)controlEvent title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvent];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)buttonWithTarget:(id)target action:(SEL)action forControlEvent:(UIControlEvents)controlEvent image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvent];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
