//
//  XSToolView.m
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSToolView.h"

#define TOOL_BTN_H 35
#define TOOL_BTN_W self.width/5

#define XSToolBtnImageLeftMargin (TOOL_BTN_W - 20)*0.5

@interface XSToolView ()

/** pop按钮 */
@property (nonatomic,strong) UIButton *popBtn;

/** 喜欢按钮 */
@property (nonatomic,strong) UIButton *favoBtn;

/** 离线下载按钮 */
@property (nonatomic,strong) UIButton *downloadBtn;

/** 评论按钮 */
@property (nonatomic,strong) UIButton *comBtn;
/** 分享按钮 */
@property (nonatomic,strong) UIButton *shareBtn;

@end

@implementation XSToolView

#pragma mark - 重绘给工具条添加上方阴影
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 20/255.0, 20/255.0, 20/255.0, 1);
    CGContextSetLineWidth(context, 0.5f);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.width, 0);
    
    CGContextStrokePath(context);
    
}

#pragma mark - 单例创建新闻内容下方的工具栏
+(instancetype)sharedInstance
{
    __strong static XSToolView *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat toolX = 0;
        CGFloat toolY = SCREEN_H - TOOL_H;
        sharedManager = [[XSToolView alloc] initWithFrame:CGRectMake(toolX, toolY, SCREES_W, SCREEN_H)];
        sharedManager.backgroundColor = RGBA(225, 225, 225, 0.5);
    });
    return sharedManager;
}

#pragma mark - 设置工具栏按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _popBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_back"] selImage:[UIImage imageNamed:@"tool_back_sel"] target:self action:@selector(btnTapped:) type:XSPopBtn];
        
        _favoBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_favo"] selImage:[UIImage imageNamed:@"tool_favo_sel"] target:self action:@selector(btnTapped:) type:XSFavoBtn];

        _downloadBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_download"] selImage:[UIImage imageNamed:@"tool_download_sel"] target:self action:@selector(btnTapped:) type:XSDownloadBtn];
        
        _comBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_com"] selImage:[UIImage imageNamed:@"tool_com_sel"] target:self action:@selector(btnTapped:) type:XSComBtn];
        
        _shareBtn = [self setUpToolBtnWithImage:[UIImage imageNamed:@"tool_share"] selImage:[UIImage imageNamed:@"tool_share_sel"] target:self action:@selector(btnTapped:) type:XSShareBtn];
    }
    return self;
}

#pragma mark - 快速创建工具栏按钮
-(UIButton *)setUpToolBtnWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action type:(XSToolBtnType)type
{
    UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolBtn setImage:image forState:UIControlStateNormal];
    [toolBtn setImage:selImage forState:UIControlStateHighlighted];
    [toolBtn setImageEdgeInsets:UIEdgeInsetsMake(7.5, XSToolBtnImageLeftMargin, 7.5, XSToolBtnImageLeftMargin)];
    toolBtn.tag = type;
    [toolBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return toolBtn;
}

#pragma mark - 设置子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = TOOL_BTN_W;
    CGFloat btnH = TOOL_BTN_H;
    
    _popBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _favoBtn.frame = CGRectMake(btnW, btnY, btnW, btnH);;
    _downloadBtn.frame = CGRectMake(btnW*2, btnY, btnW, btnH);;
    _comBtn.frame = CGRectMake(btnW*3, btnY, btnW, btnH);;
    _shareBtn.frame = CGRectMake(btnW*4, btnY, btnW, btnH);;

    [self addSubview:_popBtn];
    [self addSubview:_favoBtn];
    [self addSubview:_downloadBtn];
    [self addSubview:_comBtn];
    [self addSubview:_shareBtn];

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
        
    }else if(button.tag == XSComBtn){
        //评论
        if ([_delegate respondsToSelector:@selector(toolView:buttonType:)]) {
            [_delegate toolView:self buttonType:XSComBtn];
        }
        
    }else{
        //分享
        XSLog(@"share");
    }
    
    
}

@end
