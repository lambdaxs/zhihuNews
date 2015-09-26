//
//  XSFavouriteController.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSFavouriteController.h"

@interface XSFavouriteController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

//@property (nonatomic,strong) UIView *naviView;

@end

@implementation XSFavouriteController


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - 懒加载顶部拦
//-(UIView *)naviView
//{
//    if (!_naviView) {
//        UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
//        naviView.backgroundColor = [UIColor whiteColor];
//        //顶部返回按钮
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//        backBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
//        backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        backBtn.frame = CGRectMake(0, 20, 35, 35);
//        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        [naviView addSubview:backBtn];
//        
//        //中间标题label
//        UILabel *favoLabel = [[UILabel alloc] init];
//        favoLabel.text = @"收藏";
//        favoLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
//        favoLabel.textAlignment = NSTextAlignmentCenter;
//        favoLabel.textColor = [UIColor blackColor];
//        favoLabel.frame = CGRectMake(0, 20, naviView.width, 35);
//        [naviView addSubview:favoLabel];
//        
//        _naviView = naviView;
//    }
//    return _naviView;
//}

//-(void)back
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收藏";
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableView data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *favoCell = @"favo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:favoCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:favoCell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0;
}

@end
