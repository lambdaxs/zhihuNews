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
#import "XSCellHeadView.h"
/** 顶部视图高度 */
#define TOP_VIEW_HEIGHT 220

@interface XSHomeController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) SDCycleScrollView *topStoriesView;

/** 数据源数组 */
@property (nonatomic,strong) NSMutableArray *todayArray;

@property (nonatomic,assign) NSInteger footRefreshTimes;

@end

@implementation XSHomeController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置属性
    [self setUpProperty];

    //设置标题按钮 和 导航按钮
    [self setUpTitleBtn];
    [self setUpNaviBarItems];
    
    //设置表格刷新组件
    [_tableView addHeaderWithTarget:self action:@selector(getNewStories)];
    [_tableView headerBeginRefreshing];
    [_tableView addFooterWithTarget:self action:@selector(getOldStories)];
    
}

#pragma mark - 获取最新故事
-(void)getNewStories
{
    [XSResultTool getNewDictForSuccess:^(XSResult *result) {

        //结束下拉刷新
        [_tableView headerEndRefreshing];
        
        //第一次下拉刷新加载
        if (_todayArray.count == 0) {
            [_todayArray addObject:result];
        }else{
            //多次下拉刷新 先移除旧的最新的模型 再在最前面加入最新模型
            [_todayArray removeObjectAtIndex:0];
            [_todayArray insertObject:result atIndex:0];
        }
        
        //顶部视图的延时加载
        _topStoriesView.topStoriesArray = (NSMutableArray *)result.top_stories;
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

#pragma mark - 获取旧故事
-(void)getOldStories
{
    //获得n天前的日期字符串
    NSString *dateStr = [NSString getThePastDayWithNumber:(_footRefreshTimes++)];

#warning mark - 知乎api应该再优化一些，把要传的参数都抽象成参数模型，设计方法会方便一些
    XSResultTool *resultTool = [[XSResultTool alloc] init];
    resultTool.dateStr = dateStr;
    
    [resultTool getOldDictForSuccess:^(XSResult *result) {
        //结束下拉刷新
        [_tableView footerEndRefreshing];
        
        //将得到模型添加到数据源数组中
        [_todayArray addObject:result];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

#pragma mark - 设置属性
-(void)setUpProperty
{
    /** 表格数据源数组 */
    _todayArray = [NSMutableArray array];
    
    //tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollsToTop = YES;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    //banner
    SDCycleScrollView *headView = [SDCycleScrollView cycleScrollViewDefaultWithFrame:CGRectMake(0, 0, self.view.width, TOP_VIEW_HEIGHT)];
    headView.delegate = self;
    tableView.tableHeaderView = headView;
    _topStoriesView = headView;
}

#pragma mark - 设置标题按钮刷新界面
-(void)setUpTitleBtn
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [titleBtn addTarget:_tableView action:@selector(headerBeginRefreshing) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
}

#pragma mark - 设置导航栏按钮
-(void)setUpNaviBarItems
{
    //左边收藏按钮
    UIBarButtonItem *leftItem = [UIBarButtonItem buttonWithTarget:self action:@selector(favoTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_favo"] selImage:[UIImage imageNamed:@"navi_favo_sel"]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边设置按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem buttonWithTarget:self action:@selector(settingTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"navi_setting"] selImage:[UIImage imageNamed:@"navi_setting_sel"]];
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
/** 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _todayArray.count;
}
/** 每组行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XSResult *result = _todayArray[section];
    return result.stories.count;
}
/** 设置具体的cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSStoriesCell *cell = [XSStoriesCell storiesCellWithTableView:tableView];
    
    XSResult *result = _todayArray[indexPath.section];
    XSStories *stories = result.stories[indexPath.row];
    cell.storiesModel = stories;
    
    return cell;
}
/** 设置每个cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
/** 设置头视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)return nil;
    XSResult *result = _todayArray[section];
    XSCellHeadView *view = [XSCellHeadView cellHeadViewWithFrame:CGRectMake(0, 0, self.view.width, CELL_HEAD_HEIGHT)];
    view.dateStr = result.date;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : CELL_HEAD_HEIGHT;
}
//底部视图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    [view setBackgroundColor:[UIColor clearColor]];    
    return view;
}

#pragma mark - Table view delegate
/** 点击cell后跳转 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSResult *result = _todayArray[indexPath.section];
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
