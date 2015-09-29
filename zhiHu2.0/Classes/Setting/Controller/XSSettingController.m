//
//  XSSettingController.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSSettingController.h"
#import "XSAboutController.h"
#import "XSDonateController.h"

#import "XSSetting.h"

#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Extend.h"

@interface XSSettingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) XSSetting *settingModel;

@end

@implementation XSSettingController

#pragma mark - 懒加载设置模型
-(XSSetting *)settingModel
{
    if (!_settingModel) {
        _settingModel = [XSSetting settingWithPlist];
    }
    return _settingModel;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds  style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.tableView];
    
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.settingModel.setting.count;
    }
    return self.settingModel.about.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.settingModel.setting[indexPath.row];

    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.settingModel.about[indexPath.row];
    }
    
    
    return cell;
    
}
/** 返回底部说明 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Created By Luciferxs.";;
    }
    return nil;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击清除缓存
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 停止所有的下载
        [[SDWebImageManager sharedManager] cancelAll];
        // 删除缓存
        [[SDWebImageManager sharedManager].imageCache clearMemory];
        
        [MBProgressHUD showSuccess:@"已清除"];

    }
    
    if (indexPath.section == 1) {
    
        if (indexPath.row == 0) {
            //进入捐献界面
            XSDonateController *vc = [[XSDonateController alloc] init];
            vc.title = @"捐赠";
            vc.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //进入关于界面
            XSAboutController *vc = [[XSAboutController alloc] init];
            vc.title = @"关于";
            vc.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }
}

@end
