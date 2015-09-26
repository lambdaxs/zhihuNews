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
#import "MJRefresh.h"
#import "SDCycleScrollView.h"

#import "XSResultTool.h"
#import "XSStories.h"
#import "XSTopStories.h"
#import "XSStoriesCell.h"

@interface XSHomeController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) SDCycleScrollView *topStoriesView;

/** 存放故事模型的数组 */
@property (nonatomic,strong) NSMutableArray *storiesArray;
/** 存放顶部故事模型的数组 */
@property (nonatomic,strong) NSMutableArray *topStoriesArray;

@end

@implementation XSHomeController

#pragma mark - 懒加载tableview
-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
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

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    //导航按钮组件
    [self setUpNaviBarItems];
    
    //表格刷新组件
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeaderWithTarget:self action:@selector(getNewStories)];
    
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 后台获取最新故事
-(void)getNewStories
{
    [XSResultTool getNewStoriesForSuccess:^(NSArray *storiesArray, NSArray *topStoriesArray) {
        
        [self.tableView headerEndRefreshing];
        
        _storiesArray = (NSMutableArray *)storiesArray;
        _topStoriesArray = (NSMutableArray *)topStoriesArray;

        //给顶部视图赋值
        _topStoriesView.topStoriesArray = _topStoriesArray;
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

#pragma mark - 设置导航栏按钮
-(void)setUpNaviBarItems
{
    //左边收藏按钮
    UIBarButtonItem *leftItem = [UIBarButtonItem buttonWithTarget:self action:@selector(favoTapped) forControlEvent:UIControlEventTouchUpInside title:@"收藏"];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边设置按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem buttonWithTarget:self action:@selector(settingTapped) forControlEvent:UIControlEventTouchUpInside title:@"设置"];
//    UIBarButtonItem *rightItem = [UIBarButtonItem buttonWithTarget:self action:@selector(settingTapped) forControlEvent:UIControlEventTouchUpInside image:[UIImage imageNamed:@"settingIcon"]];
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
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return self.storiesArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _storiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSStoriesCell *cell = [XSStoriesCell storiesCellWithTableView:tableView];
    
    XSStories *stories = _storiesArray[indexPath.row];
    cell.storiesModel = stories;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHight;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSStories *stories = _storiesArray[indexPath.row];
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
