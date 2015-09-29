//
//  XSContentController.m
//  zhihuNews
//
//  Created by xiaos on 15/9/12.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSContentController.h"

#import "MBProgressHUD+Extend.h"
#import "MJExtension.h"

#import "XSResultTool.h"
#import "XSToolView.h"
#import "XSCssFile.h"

@interface XSContentController ()<UIWebViewDelegate,XSToolViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

//@property (nonatomic,weak) UIView *tempView;

/** 接收的内容Url */
@property (nonatomic,copy) NSString *storiesId;


@end

@implementation XSContentController

-(UIWebView *)webView
{
    if (!_webView) {
        //承载webView的一个view 在滚动web时上面的状态栏不会遮挡住web内容
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - (XSToolHeight + 20))];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bgView];
        _webView = [[UIWebView alloc] initWithFrame:bgView.bounds];
        _webView.delegate = self;
        
        //添加底部工具栏
        XSToolView *toolBar = [XSToolView sharedInstance];
        toolBar.delegate = self;
        [self.view addSubview:toolBar];
        
        [bgView addSubview:_webView];
    }
    return _webView;
}

#pragma mark - 类方法直接返回初始化好的控制器对象
+(instancetype)contentViewWithStoiresId:(NSString *)storiesId
{
    XSContentController *contentVC = [[self alloc] init];
    contentVC.storiesId = storiesId;
    [MBProgressHUD showMessage:@"正在加载..."];
    return contentVC;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 为故事id赋值 然后加载内容
-(void)setStoriesId:(NSString *)storiesId
{
    _storiesId = storiesId;
    
    XSResultTool *resultTool = [[XSResultTool alloc] init];
    resultTool.stoiresId = storiesId;
    [resultTool getStoriesContentWithSuccess:^(NSString *htmlStr) {
        [MBProgressHUD hideHUD];
        //加载网页
        [self.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[XSCssFile getPathOfCssFile]]];
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接不稳定"];

    }];
    
}

#pragma mark - implement UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"网络连接不稳定"];
}

#pragma mark - implement toolviewDelegate
-(void)toolView:(XSToolView *)view buttonType:(XSToolBtnType)type
{
    //对应工具栏按钮 分别在代理方法中实现对应功能
    switch (type) {
        case XSPopBtn:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case XSFavoBtn:
            [MBProgressHUD showSuccess:@"已点赞"];
            
            break;
        case XSDownloadBtn:
            [MBProgressHUD showSuccess:@"已下载"];
            break;
        case XSComBtn:
            [MBProgressHUD showSuccess:@"评论"];

            break;
    }
    
}

@end
