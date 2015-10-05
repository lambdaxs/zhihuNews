//
//  XSNavigationController.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSNavigationController.h"

#import "XSContentController.h"

#import "UIBarButtonItem+XSNaviItem.h"

@interface XSNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation XSNavigationController


#pragma mark - 统一设置导航栏样式
+(void)initialize
{
    // 设置导航条按钮的文字颜色
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSDictionary *titleAttr = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]};
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    //设置导航条背景图片 文字样式
    UINavigationBar *naviBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
//    [naviBar setBackgroundImage:[UIImage imageNamed:@"naviBarbg"] forBarMetrics:UIBarMetricsDefault];
    [naviBar setTitleTextAttributes:titleAttr];
    
    
    //设置状态栏为浅色
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消导航栏边界阴影
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.delegate = self;
    
    //自定义返回按钮后 添加滑动返回手势
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
}


#pragma mark - overried push 设置超过二级界面的返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        UIBarButtonItem *leftItem = [UIBarButtonItem buttonWithTarget:self action:@selector(popBack) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_back"] selImage:[UIImage imageNamed:@"navi_back_sel"]];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    //进入故事详情界面时 隐藏naviBar
    if ([viewController isKindOfClass:[XSContentController class]]) {
        [self setNavigationBarHidden:YES animated:YES];
        //防止出现wUIWebview出现20px偏移
        viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)popBack
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - navi ctrl delegate
/** 处理自定义返回按钮后的手势 */
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //是根控制器 关闭主界面的滑动返回
    if (viewController == self.viewControllers[0]) {
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }else{
        //非根控制器 开启滑动返回
        if (!self.interactivePopGestureRecognizer.enabled) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //回到根控制器
    if (viewController == [self.childViewControllers firstObject]) {
        //恢复navibar的显示
        [self setNavigationBarHidden:NO animated:YES];
    }
        
    

}


@end
