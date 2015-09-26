//
//  XSCssFile.m
//  zhihuNews
//
//  Created by xiaos on 15/9/13.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSCssFile.h"

/** css文件路径 */
#define cssFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"news.css"]

/** cssUrl文件路径 */
#define cssUrlPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cssUrl.txt"]


@implementation XSCssFile


/** 更新css文件和网络路径到本地磁盘 */
+(void)saveCssFileWithUrl:(NSString *)url
{

    //更新css文件的网络路径
    [url writeToFile:cssUrlPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    XSLog(@"缓存路径%@",cssFilePath);

    //更新css文件
    NSURL *cssUrl = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:cssUrl];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [data writeToFile:cssFilePath atomically:YES];
    }];
}

/** 返回css文件父目录的路径 */
+(NSString *)getPathOfCssFile
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return path;
}


/** 返回cssUrl的内容 */
+ (NSString *)getoOldCssUrl
{
    return [NSString stringWithContentsOfFile:cssUrlPath encoding:NSUTF8StringEncoding error:nil];;
}

@end
