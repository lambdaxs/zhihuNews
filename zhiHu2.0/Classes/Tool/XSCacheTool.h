//
//  XSCacheTool.h
//  zhiHu2.0
//
//  Created by xiaos on 15/10/16.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATE_KEY            @"date"
#define STORIES_KEY         @"stoires"
#define DOWNLOAD_KEY        @"download"

@interface XSCacheTool : NSObject

+ (void)saveCacheWithObject:(id)object forKey:(NSString *)key;
+ (id)getCacheObjectWithKey:(NSString *)key;


/** 根据日期保存 */
+ (void)saveCacheWithObject:(id)object forDateKey:(NSString *)key;
/** 根据故事id保存 */
+ (void)saveCacheWithObject:(id)object forSotiresKey:(NSString *)key;
/** 根据下载收藏保存 */
+ (void)saveCacheWithObject:(id)object forDownloadKey:(NSString *)key;


/** 日期key取值 */
+ (id)getCacheObjectWithDateKey:(NSString *)key;
/** 故事idkey取值 */
+ (id)getCacheObjectWithSotiresKey:(NSString *)key;
/** 下载key取值 */
+ (id)getCacheObjectWithDownloadKey:(NSString *)key;


@end
