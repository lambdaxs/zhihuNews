//
//  XSFavouriteController.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSFavouriteController.h"
#import "XSResult.h"
#import "XSCacheTool.h"

@interface XSFavouriteController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *modelsArray;
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

-(NSArray *)modelsArray {
    if (!_modelsArray) {
        //遍历down开头的key 将对象存入数组 再解析
//        [[NSUserDefaults standardUserDefaults] ];
//        [XSCacheTool getCacheObjectWithDownloadKey:<#(NSString *)#>];
    }
    return _modelsArray;
}



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
