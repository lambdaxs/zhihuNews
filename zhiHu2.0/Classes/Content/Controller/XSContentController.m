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
//#import "AFNetworking.h"
#import "XSHttpTool.h"

#import "XSToolView.h"
#import "XSCssFile.h"
#import "XSContentResult.h"

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
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 55)];
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
    
    NSString *contentURL = [@"http://news-at.zhihu.com/api/4/news/" stringByAppendingString:storiesId];
    
    [XSHttpTool GET:contentURL parameters:nil success:^(id responseObject) {
        
        [MBProgressHUD hideHUD];
        
        //字典转模型
        XSContentResult *result = [XSContentResult objectWithKeyValues:responseObject];
        //内容正文
        NSString *bodyStr = result.body;
        //获取css文件的url
        NSString *cssUrl = [result.css lastObject];
        
        //若旧的url为空 或者旧的url与新的url不一样 就从网络上下载 更新css文件
        if (![cssUrl isEqualToString:[XSCssFile getoOldCssUrl]] || ![XSCssFile getoOldCssUrl]) {
            XSLog(@"更新css文件");
            [XSCssFile saveCssFileWithUrl:cssUrl];
        }
        //若css文件url一致 直接从本地读取
        NSString *htmlHead = @"<html><head><title></title><link type=\"text/css\" rel=\"stylesheet\" href = \"news.css\" /></head><body>";
        NSString *htmlFoot = @"</body></html>";
        NSString *htmlStr = [NSString stringWithFormat:@"%@%@%@",htmlHead,bodyStr,htmlFoot];
        
        //加载网页
        [self.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[XSCssFile getPathOfCssFile]]];

        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接不稳定"];
 
    }];
    
}

#pragma mark - implement UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"网络连接不稳定"];
}

#pragma mark - implement toolviewDelegate
-(void)toolView:(XSToolView *)view
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
