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

#import "XSResultTool.h"
#import "XSStories.h"
#import "XSTopStories.h"
#import "XSStoriesCell.h"

@interface XSHomeController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) SDCycleScrollView *topStoriesView;

/** 存放结果模型 包含了故事模型和顶部故事模型 */
@property (nonatomic,strong) NSMutableArray *todayArray;

/** 下拉刷新次数 */
@property (nonatomic,assign) NSInteger footRefreshTimes;

@end

@implementation XSHomeController

#pragma mark - 懒加载tableview
-(UITableView *)tableView
{
    if (!_tableView) {
        //组样式表格
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //网络加载图片轮播器
        SDCycleScrollView *headView = [SDCycleScrollView cycleScrollViewDefaultWithFrame:CGRectMake(0, 0, self.view.width, 220)];
        headView.delegate = self;
        _topStoriesView = headView;

        tableView.tableHeaderView = headView;
        _tableView = tableView;
    }
    return _tableView;
}

-(NSMutableArray *)todayArray
{
    if (!_todayArray) {
        _todayArray = [NSMutableArray array];
    }
    return _todayArray;
}


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题按钮 和 导航按钮
    [self setUpTitleBtn];
    [self setUpNaviBarItems];
    
    //设置表格刷新组件
    [self.view addSubview:self.tableView];
    [self.tableView addHeaderWithTarget:self action:@selector(getNewStories)];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(getOldStories)];
    
}

#pragma mark - 后台获取最新故事
-(void)getNewStories
{
    [XSResultTool getNewDictForSuccess:^(XSResult *result) {

        [self.tableView headerEndRefreshing];
        
        if (self.todayArray.count == 0) {
            //下拉刷新第一次加载
            [self.todayArray addObject:result];
        }else{
            //多次下拉刷新 先移除旧的最新的模型 再在最前面加入最新模型
            [self.todayArray removeObjectAtIndex:0];
            [self.todayArray insertObject:result atIndex:0];
        }
        
        _topStoriesView.topStoriesArray = (NSMutableArray *)result.top_stories;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

#pragma mark - 后台获取旧故事
-(void)getOldStories
{
    //每次下拉刷新加1
    _footRefreshTimes++;
    //获得之前一天日期的字符串封装成NSNumber
    NSString *todayDateStr = [NSString stringWithToday];
    NSNumber *dateNum = [NSNumber numberWithLongLong:(todayDateStr.longLongValue - _footRefreshTimes)];
    
    XSResultTool *resultTool = [[XSResultTool alloc] init];
    resultTool.dateStr = dateNum.stringValue;
    
    [resultTool getOldDictForSuccess:^(XSResult *result) {
        
        [self.tableView footerEndRefreshing];
        [self.todayArray addObject:result];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

#pragma mark - 设置标题按钮刷新界面
-(void)setUpTitleBtn
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [titleBtn addTarget:self.tableView action:@selector(headerBeginRefreshing) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
}

#pragma mark - 设置导航栏按钮
-(void)setUpNaviBarItems
{
    //左边收藏按钮
    UIBarButtonItem *leftItem = [UIBarButtonItem buttonWithTarget:self action:@selector(favoTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_favo"]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边设置按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem buttonWithTarget:self action:@selector(settingTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_setting"]];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)settingTapped
{
    XSSettingController *settingVC  =[[XSSettingController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(void)favoTapped
{
    XSFavouriteController *favoVC = [[XSFavouriteController alloc] init];
    [self.navigationController pushViewController:favoVC animated:YES];
}

#pragma mark - Table view data source
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
    XSStoriesCell *cell = [XSStoriesCell storiesCellWithTableView:tableView];
    
    XSResult *result = self.todayArray[indexPath.section];
    XSStories *stories = result.stories[indexPath.row];
    cell.storiesModel = stories;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    XSResult *result = self.todayArray[section];
    return result.date;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHight;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSResult *result = self.todayArray[indexPath.section];
    XSStories *stories = result.stories[indexPath.row];
    NSString *idStr = stories.id.stringValue;
    XSContentController *contentVC = [XSContentController contentViewWithStoiresId:idStr];
    [self.navigationController pushViewController:contentVC animated:YES];
}

#pragma mark - 顶部视图的代理
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSUInteger)index topStoiresIdStr:(NSString *)idStr
{
    XSContentController *contentVC = [XSContentController contentViewWithStoiresId:idStr];
    [self.navigationController pushViewController:contentVC animated:YES];
}
@end
