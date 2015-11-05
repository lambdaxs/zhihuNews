//
//  XSHomeController.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSHomeController.h"
#import "XSSettingController.h"
#import "XSFavouriteController.h"
#import "XSContentController.h"

#import "UIBarButtonItem+XSNaviItem.h"
#import "NSString+XSDate.h"

#import "MJRefresh.h"
#import "SDCycleScrollView.h"

#import "XSStories.h"
#import "XSTopStories.h"

#import "XSStoriesCell.h"
#import "XSHeadView.h"

#import "XSResultTool.h"
#import "XSCacheTool.h"

/** 顶部视图高度 */
static const CGFloat topViewHeight = 220.0f;

@interface XSHomeController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate>

/** 顶部轮播图片 */
@property (nonatomic,strong) SDCycleScrollView *topStoriesView;
/** 标题按钮 */
@property (nonatomic,strong) UIButton *titleButton;
/** 收藏按钮 */
@property (nonatomic,strong) UIBarButtonItem *favoButton;
/** 设置按钮 */
@property (nonatomic,strong) UIBarButtonItem *settingButton;

/** 数据源数组 */
@property (nonatomic,strong) NSMutableArray *todayArray;
/** 下拉刷新次数 */
@property (nonatomic,assign) NSInteger footRefreshTimes;

@end

@implementation XSHomeController

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>生命周期
#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerClass:[XSStoriesCell class] forCellReuseIdentifier:@"stoires"];
    [self.tableView registerClass:[XSHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
    //添加上下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(getNewStories)];
    [self.tableView addFooterWithTarget:self action:@selector(getOldStories)];
    //顶部banner
//    self.tableView.tableHeaderView = self.topStoriesView;
//    self.tableView.contentOffset = CGPointMake(0, 64);

    //设置按钮
    self.navigationItem.titleView = self.titleButton;
    self.navigationItem.leftBarButtonItem = self.favoButton;
    self.navigationItem.rightBarButtonItem = self.settingButton;
    
    //获取离线数据
    [self getCacheData];
    
    //自动下拉刷新
    //    [self.tableView headerBeginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>代理方法
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.todayArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XSResult *result = self.todayArray[section];
    return result.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSStoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stoires" forIndexPath:indexPath]; 
    
    XSResult *result = self.todayArray[indexPath.section];
    XSStories *stories = result.stories[indexPath.row];
    cell.storiesModel = stories;
    
    return cell;
}
/** 设置cell高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
/** 设置头视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)return nil;
    XSResult *result = self.todayArray[section];
    XSHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    view.dateStr = result.date;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : cellHeadViewHeight;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSResult *result = self.todayArray[indexPath.section];
    XSStories *stories = result.stories[indexPath.row];

    XSContentController *contentVC = [XSContentController contentViewWithStoiresId:stories.id.stringValue];
    [self.navigationController pushViewController:contentVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSUInteger)index topStoiresIdStr:(NSString *)idStr
{
    XSContentController *contentVC = [XSContentController contentViewWithStoiresId:idStr];
    [self.navigationController pushViewController:contentVC animated:YES];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>事件响应
#pragma mark - event response
-(void)settingButtonTapped
{
    [self.navigationController pushViewController:[[XSSettingController alloc] init] animated:YES];
}

-(void)favoButtonTapped
{
    [self.navigationController pushViewController:[[XSFavouriteController alloc] init] animated:YES];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>私有方法 大多数方法可以抽取到缓存类中
#pragma mark - private methods
/** 获取离线数据 */
- (void)getCacheData
{
    NSString *todayStr = [NSString getThePastDayWithNumber:0];
    id response = [XSCacheTool getCacheObjectWithDateKey:todayStr];
    
    //response为空 刷新获取最新故事
    if (!response) {
        [self.tableView headerBeginRefreshing];
        return;
    }
    
    //请求成功操作
    XSResult *result = [XSResult objectWithKeyValues:response];
    [self requestNewsSuccessWithResult:result];
}

/** 获取新故事 */
- (void)getNewStories
{
    weakSelf();
    [XSResultTool getNewDictForSuccess:^(XSResult *result) {
        [weakSelf requestNewsSuccessWithResult:result];
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

/** 获取旧故事 */
- (void)getOldStories
{
    //获得n天前的日期字符串
    NSString *dateStr = [NSString getThePastDayWithNumber:(self.footRefreshTimes++)];
    NSString *oldDateStr = [NSString getThePastDayWithNumber:(self.footRefreshTimes)];
    
    //有缓存就从缓存层获取 没有就调用网络层获取
    id response = [XSCacheTool getCacheObjectWithDateKey:oldDateStr];
    if (response) {
        XSResult *result = [XSResult objectWithKeyValues:response];
        [self requestOldSuccessWithResult:result];
        return;
    }
    
    weakSelf();
    [XSResultTool getOldDictWithDateStr:dateStr forSuccess:^(XSResult *result) {
        [weakSelf requestOldSuccessWithResult:result];
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

/** 获得新故事请求成功后的操作 */
-(void)requestNewsSuccessWithResult:(XSResult *)result
{
    [self.tableView headerEndRefreshing];
    //第一次加载
    if (!self.todayArray.count) {
        [self.todayArray addObject:result];
    }else{
        //多次加载 先移除旧的最新的模型 然后在最前面加入最新模型
        [self.todayArray removeObjectAtIndex:0];
        [self.todayArray insertObject:result atIndex:0];
    }
    //顶部视图的延时加载
//    self.topStoriesView.topStoriesArray = (NSMutableArray *)result.top_stories;
    [self.tableView reloadData];
}

/** 旧故事请求成功后的操作 */
-(void)requestOldSuccessWithResult:(XSResult *)result
{
    [self.tableView footerEndRefreshing];
    //将得到模型添加到数据源数组中
    [self.todayArray addObject:result];
    [self.tableView reloadData];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>geter && setter
#pragma mark - getter & setter
-(NSMutableArray *)todayArray
{
    if (!_todayArray) {
        _todayArray = [NSMutableArray array];
    }
    return _todayArray;
}

-(SDCycleScrollView *)topStoriesView
{
    if (!_topStoriesView) {
        _topStoriesView = [SDCycleScrollView cycleScrollViewDefaultWithFrame:CGRectMake(0, 0, self.view.width, topViewHeight)];
        _topStoriesView.delegate = self;
    }
    return _topStoriesView;
}

-(UIButton *)titleButton
{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitle:@"首页" forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_titleButton addTarget:self.tableView action:@selector(headerBeginRefreshing) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton sizeToFit];

    }
    return _titleButton;
}

-(UIBarButtonItem *)favoButton
{
    if (!_favoButton) {
        _favoButton = [UIBarButtonItem buttonWithTarget:self action:@selector(favoButtonTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_favo"] selImage:[UIImage imageNamed:@"navi_favo_sel"]];
    }
    return _favoButton;
}

-(UIBarButtonItem *)settingButton
{
    if (!_settingButton) {
        _settingButton = [UIBarButtonItem buttonWithTarget:self action:@selector(settingButtonTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_setting"] selImage:[UIImage imageNamed:@"navi_setting_sel"]];
    }
    return _settingButton;
}

@end