//
//  XSToolView.m
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSToolView.h"


#define XSToolBtnHeight 20
#define XSToolMargin (self.width - 20*4)/5

@interface XSToolView ()

/** pop按钮 */
@property (nonatomic,strong) UIButton *popBtn;

/** 喜欢按钮 */
@property (nonatomic,strong) UIButton *favoBtn;

/** 离线下载按钮 */
@property (nonatomic,strong) UIButton *downloadBtn;

/** 评论按钮 */
@property (nonatomic,strong) UIButton *comBtn;

@end

@implementation XSToolView

#pragma mark - 单例创建新闻内容下方的工具栏
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

#pragma mark - 设置工具栏按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _popBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_back"] target:self action:@selector(btnTapped:) type:XSPopBtn];
        
        _favoBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_favo"] target:self action:@selector(btnTapped:) type:XSFavoBtn];

        _downloadBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_download"] target:self action:@selector(btnTapped:) type:XSDownloadBtn];
        
        _comBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_com"] target:self action:@selector(btnTapped:) type:XSComBtn];
        
    }
    return self;
}

#pragma mark - 快速创建工具栏按钮
-(UIButton *)setUpToolBtnWithImage:(UIImage *)image target:(id)target action:(SEL)action type:(XSToolBtnType)type
{
    UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolBtn setBackgroundImage:image forState:UIControlStateNormal];
    [toolBtn sizeToFit];
    toolBtn.tag = type;
    [toolBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return toolBtn;
}

#pragma mark - 设置子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnX = XSToolMargin;
    CGFloat btnY = (XSToolHeight - XSToolBtnHeight) >> 1;
    CGFloat btnW = XSToolBtnHeight;
    CGFloat btnH = btnW;
    
    _popBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _favoBtn.frame = CGRectMake(btnX*2 + btnW, btnY, btnW, btnH);;
    _downloadBtn.frame = CGRectMake(btnX*3 + btnW*2, btnY, btnW, btnH);;
    _comBtn.frame = CGRectMake(btnX*4 + btnW*3, btnY, btnW, btnH);;

    [self addSubview:_popBtn];
    [self addSubview:_favoBtn];
    [self addSubview:_downloadBtn];
    [self addSubview:_comBtn];

}

#pragma mark - 点击返回按钮 在content界面中响应代理 pop出界面！
-(void)btnTapped:(UIButton *)button
{
    if (button.tag == XSPopBtn) {
        //返回上一级
        if ([_delegate respondsToSelector:@selector(toolView:buttonType:)]) {
            [_delegate toolView:self buttonType:XSPopBtn];
        }
    }else if (button.tag == XSFavoBtn){
        //点赞
        if ([_delegate respondsToSelector:@selector(toolView:buttonType:)]) {
            [_delegate toolView:self buttonType:XSFavoBtn];
        }
        
    }else if(button.tag == XSDownloadBtn){
        //离线下载
        if ([_delegate respondsToSelector:@selector(toolView:buttonType:)]) {
            [_delegate toolView:self buttonType:XSDownloadBtn];
        }
        
    }else{
        //评论
        if ([_delegate respondsToSelector:@selector(toolView:buttonType:)]) {
            [_delegate toolView:self buttonType:XSComBtn];
        }
        
    }
    
    
}

@end
