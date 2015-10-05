//
//  XSRemoveCache.h
//  zhiHu2.0
//
//  Created by xiaos on 15/10/1.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning mark - 清除缓存功能有待完善 现在只是调用得到缓存大小

@interface XSRemoveCache : NSObject

/** 计算缓存文件夹大小 并写入本地磁盘 */
+ (void)saveCacheSize;

/** 得到所有缓存大小 */
+ (NSString *)getCacheSizeFile;

/** 删除缓存 */
- (void)removeCache;

+ (void)clearCache;


@end
