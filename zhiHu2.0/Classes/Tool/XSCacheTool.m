//
//  XSCacheTool.m
//  zhiHu2.0
//
//  Created by xiaos on 15/10/16.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSCacheTool.h"

@implementation XSCacheTool

+ (void)saveCacheWithObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getCacheObjectWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

/** 根据日期保存 */
+ (void)saveCacheWithObject:(id)object forDateKey:(NSString *)key {
    NSString *dateKey = [NSString stringWithFormat:@"%@%@",DATE_KEY,key];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:dateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/** 根据故事id保存 */
+ (void)saveCacheWithObject:(id)object forSotiresKey:(NSString *)key {
    NSString *stoiresKey = [NSString stringWithFormat:@"%@%@",STORIES_KEY,key];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:stoiresKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/** 根据下载收藏保存 */
+(void)saveCacheWithObject:(id)object forDownloadKey:(NSString *)key {
    NSString *downloadKey = [NSString stringWithFormat:@"%@%@",DOWNLOAD_KEY,key];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:downloadKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)dealloc
{
    XSLog(@"缓存工具销毁");
}
/** 取方法 */
/** 日期key取值 */
+ (id)getCacheObjectWithDateKey:(NSString *)key {
    NSString *dateKey = [NSString stringWithFormat:@"%@%@",DATE_KEY,key];
    return [[NSUserDefaults standardUserDefaults] valueForKey:dateKey];
}
/** 故事idkey取值 */
+ (id)getCacheObjectWithSotiresKey:(NSString *)key {
    NSString *stoiresKey = [NSString stringWithFormat:@"%@%@",STORIES_KEY,key];
    return [[NSUserDefaults standardUserDefaults] valueForKey:stoiresKey];
}
/** 下载key取值 */
+ (id)getCacheObjectWithDownloadKey:(NSString *)key {
    NSString *downloadKey  = [NSString stringWithFormat:@"%@%@",DOWNLOAD_KEY,key];
    return [[NSUserDefaults standardUserDefaults] valueForKey:downloadKey];
}

@end
