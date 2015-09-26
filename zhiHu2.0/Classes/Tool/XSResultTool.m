//
//  XSResultTool.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSResultTool.h"

#import "XSHttpTool.h"
#import "XSResult.h"

/** 获取最新消息 */
#define newStoiresURL @"http://news-at.zhihu.com/api/4/news/latest"

@implementation XSResultTool

+(void)getNewStoriesForSuccess:(void (^)(NSArray *, NSArray *))success failure:(void (^)(NSError *))failure
{
    [XSHttpTool GET:newStoiresURL parameters:nil success:^(id responseObject) {
        //请求成功传两个数组到外层代码中
        
        //字典转模型
        XSResult *result = [XSResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.stories,result.top_stories);
        }
        
        
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}
@end
