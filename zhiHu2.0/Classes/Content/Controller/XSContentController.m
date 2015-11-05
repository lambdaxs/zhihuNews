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
#import "RTSpinKitView.h"

#import "XSResultTool.h"
#import "XSToolView.h"
#import "XSCssFile.h"
#import "XSCacheTool.h"


@interface XSContentController ()<UIWebViewDelegate,XSToolViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIView *bgView;                //浏览器承载view
@property (nonatomic,strong) XSToolView *toolBar;           //工具栏视图
@property (nonatomic,strong) RTSpinKitView *loadingHubView; //加载动画
@property (nonatomic,copy) NSString *storiesId;             //故事id

@end

@implementation XSContentController

#pragma mark - init
+ (instancetype)contentViewWithStoiresId:(NSString *)storiesId
{
    XSContentController *contentVC = [[self alloc] init];
    contentVC.storiesId = storiesId;
    return contentVC;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loadingHubView];     //加载动画
    [self.view addSubview:self.toolBar];            //底部工具栏
}

#pragma mark - Delegate
- (void)toolView:(XSToolView *)view buttonType:(XSToolBtnType)type
{
    NSMutableArray *idArray;
    NSString *downKey;
    NSArray *tempArray;
    
    //对应工具栏按钮 分别在代理方法中实现对应功能
    switch (type) {
        case XSPopBtn:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case XSFavoBtn:
            [MBProgressHUD showSuccess:@"已点赞"];
            break;
        case XSDownloadBtn:
#warning mark - 抽取逻辑到工具类中
            //离线内容保存
            tempArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"downKeyArray"];
            downKey = [NSString stringWithFormat:@"%@%@",DOWNLOAD_KEY,self.storiesId];
            [idArray addObject:self.storiesId];
            [[NSUserDefaults standardUserDefaults] setObject:idArray forKey:@"downKeyArray"];
            
            [XSCacheTool saveCacheWithObject:[XSCacheTool getCacheObjectWithSotiresKey:self.storiesId] forDownloadKey:self.storiesId];
            [MBProgressHUD showSuccess:@"已下载"];
            break;
        case XSComBtn:
            [MBProgressHUD showSuccess:@"评论"];
            break;
        case XSShareBtn:
            [MBProgressHUD showSuccess:@"分享"];
            break;
    }
    
}

#pragma mark - events response

#pragma mark - private methods

#pragma mark - getter & setter
-(UIWebView *)webView
{
    if (!_webView) {
        //承载webView的一个view 在滚动web时上面的状态栏不会遮挡住web内容
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 20, self.view.width, self.view.height - (TOOL_H + 20))];
        self.bgView = bgView;
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bgView];
        _webView = [[UIWebView alloc] initWithFrame:bgView.bounds];
        _webView.delegate = self;
        [bgView addSubview:_webView];
    }
    return _webView;
}

- (XSToolView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[XSToolView alloc] init];
        _toolBar.delegate = self;
    }
    return _toolBar;
}

- (RTSpinKitView *)loadingHubView
{
    if (!_loadingHubView) {
        _loadingHubView = [[RTSpinKitView alloc]initWithStyle:RTSpinKitViewStyleWave color:RGB(1, 120, 216)];
        _loadingHubView.hidden = YES;
        _loadingHubView.center = self.view.center;
    }
    return _loadingHubView;
}


- (void)setStoriesId:(NSString *)storiesId
{
    _storiesId = storiesId;
    
    id response = [XSCacheTool getCacheObjectWithSotiresKey:self.storiesId];
    //若已缓存 直接在缓存中读取
    if (response) {
        [self.webView loadHTMLString:[XSResultTool getHtmlStrWithResponse:response] baseURL:[NSURL fileURLWithPath:[XSCssFile getPathOfCssFile]]];
    }else{
        
        //若无缓存 调用网络库
        self.loadingHubView.hidden = NO;
        weakSelf();
        [XSResultTool getStoriesContentWithStoiresId:storiesId forSuccess:^(NSString *htmlStr) {
            
            self.loadingHubView.hidden = YES;
            [weakSelf.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[XSCssFile getPathOfCssFile]]];
            
        } failure:^(NSError *error) {
            XSLog(@"%@",error);
        }];
    }
}


@end
