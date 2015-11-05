//
//  XSResultTool.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSResultTool.h"

#import "XSHttpTool.h"
#import "MJExtension.h"

#import "XSCssFile.h"
#import "XSCacheTool.h"

#import "XSContentResult.h"

#define LAUNCH_IMAGE_API  @"//http://news-at.zhihu.com/api/4/start-image/1080*1776"
#define NEW_STORIES_API   @"http://news-at.zhihu.com/api/4/news/latest"
#define OLD_STOIRES_API   @"http://news.at.zhihu.com/api/4/news/before/"
#define CONTENT_API       @"http://news-at.zhihu.com/api/4/news/"

@implementation XSResultTool

+ (void)getLaunchImageURLForSuccess:(void (^)(NSString *imageURL))success failure:(void (^)(NSError *error))failure
{
    [XSHttpTool GET:LAUNCH_IMAGE_API parameters:nil success:^(id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSString *imageURL = [responseDict valueForKey:@"img"];
        NSLog(@"%@",imageURL);
        if (success) {
            success(imageURL);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请求最新故事
+ (void)getNewDictForSuccess:(void (^)(XSResult *))success failure:(void (^)(NSError *))failure
{
    [XSHttpTool GET:NEW_STORIES_API parameters:nil success:^(id responseObject) {
        XSResult *result = [XSResult objectWithKeyValues:responseObject];
        //离线缓存----- 保存网上下载下来的响应对象 以日期为key
        [XSCacheTool saveCacheWithObject:responseObject forDateKey:result.date];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请求以前的故事
+ (void)getOldDictWithDateStr:(NSString *)dateStr forSuccess:(void (^)(XSResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *oldURL = [OLD_STOIRES_API stringByAppendingString:dateStr];
    
    [XSHttpTool GET:oldURL parameters:nil success:^(id responseObject) {
        
        XSResult *result = [XSResult objectWithKeyValues:responseObject];
        //离线缓存----- 保存网上下载下来的响应对象 以日期为key
        [XSCacheTool saveCacheWithObject:responseObject forDateKey:result.date];

        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 请求故事内容
+ (void)getStoriesContentWithStoiresId:(NSString *)stoiresId forSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    NSString *contentURL = [CONTENT_API stringByAppendingString:stoiresId];
    
    [XSHttpTool GET:contentURL parameters:nil success:^(id responseObject) {
        
#warning mark - 抽取到缓存工具类中(需要重新设计)
        //离线缓存-----以故事id为key 保存网上下载下来的响应对象
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver",stoiresId]];
        
        NSString *favosPath = [cachePath stringByAppendingPathComponent:@"favos.txt"];
        NSMutableString *favoListItem = [NSMutableString stringWithContentsOfFile:favosPath encoding:NSUTF8StringEncoding error:nil];
        if (!favoListItem) {
            favoListItem = [NSMutableString string];
        }
        
        [favoListItem appendFormat:@"%@+",stoiresId];
        [favoListItem writeToFile:favosPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [NSKeyedArchiver archiveRootObject:responseDict toFile:filePath];
        
        [XSCacheTool saveCacheWithObject:responseObject forSotiresKey:stoiresId];
        
        //将处理好的htmlStr传出
        if (success) {
            success([self getHtmlStrWithResponse:responseObject]);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 解析传入的响应体 得到最终的html源文件
+ (NSString *)getHtmlStrWithResponse:(id)responseObject
{
    //字典转模型
    XSContentResult *result = [XSContentResult objectWithKeyValues:responseObject];
    //内容标题
    NSString *titleStr = result.title;
    //内容正文
    NSString *bodyStr = result.body;
    //获取css文件的url
    NSString *cssUrl = [result.css lastObject];
    
    //若旧的url为空 或者旧的url与新的url不一样 就从网络上下载 更新css文件
    if (![cssUrl isEqualToString:[XSCssFile getoOldCssUrl]] || ![XSCssFile getoOldCssUrl]) {
        XSLog(@"更新css文件");
        [XSCssFile saveCssFileWithUrl:cssUrl];
    }
    //若css文件url一致 直接从本地读取
    NSString *htmlHead = @"<html><head><title></title><link type=\"text/css\" rel=\"stylesheet\" href = \"news.css\" /></head><body>";
    NSString *replaceStr = [NSString stringWithFormat:@"<div class=\"headline-title\"><h1>%@</h1></div>",titleStr];
    NSRange range = [bodyStr rangeOfString:@"<div class=\"img-place-holder\"></div>"];
    
#warning mark - 防止以后知乎这里变动
    if (range.length != 0) {
        bodyStr = [bodyStr stringByReplacingCharactersInRange:range withString:replaceStr];
    }else{
        XSLog(@"内容的html页面有变动!");
    }
    NSString *htmlFoot = @"</body></html>";
    NSString *htmlStr = [NSString stringWithFormat:@"%@%@%@",htmlHead,bodyStr,htmlFoot];
    
    return htmlStr;
}

//+ (NSString *)getHtmlStrWith:(id)responseObject
//{
//   
//}

@end
