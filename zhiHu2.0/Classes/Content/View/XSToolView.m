//
//  XSToolView.m
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSToolView.h"

/** 工具栏高度 */
#define XSToolHeight 35

@interface XSToolView ()

/** pop按钮 */
@property (nonatomic,strong) UIButton *popBtn;

@end

@implementation XSToolView

/** 单例创建新闻内容下方的工具栏 */
+(instancetype)sharedInstance
{
    __strong static XSToolView *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat toolX = 0;
        CGFloat toolY = XSScreenHeight - XSToolHeight;
        sharedManager = [[XSToolView alloc] initWithFrame:CGRectMake(toolX, toolY, XSScreenWidth, XSToolHeight)];
        sharedManager.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:0.5];
    });
    
    return sharedManager;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [popBtn setTitle:@"back" forState:UIControlStateNormal];
        [popBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        _popBtn = popBtn;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 40;
    CGFloat btnH = 40;
    _popBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [self addSubview:_popBtn];
}

#pragma mark - 点击返回按钮 在content界面中响应代理 pop出界面！
-(void)pop
{
    if ([_delegate respondsToSelector:@selector(toolView:)]) {
        [_delegate toolView:self];
    }
}

@end
