//
//  XSRemoveCache.m
//  zhiHu2.0
//
//  Created by xiaos on 15/10/1.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSRemoveCache.h"

#import "UIImageView+WebCache.h"

/** cacheSizePath文件路径 */
#define CACHE_SIZE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cacheSize.txt"]

#define CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface XSRemoveCache ()

@property (nonatomic,strong) NSFileManager *manager;

@end

@implementation XSRemoveCache

-(NSFileManager *)manager
{
    if (!_manager) {
        _manager = [NSFileManager defaultManager];
    }
    return _manager;
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    if ([self.manager fileExistsAtPath:filePath]){
        return [[self.manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    if (![self.manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[self.manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

/** 将缓存文件夹大小写入到本地磁盘 */
+ (void)saveCacheSize
{
    float size = [[self alloc ] folderSizeAtPath:CACHE_PATH];
    
    NSString *sizeStr = [NSString stringWithFormat:@"%.1fM",size];
    [sizeStr writeToFile:CACHE_SIZE_PATH atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

/** 删除缓存 */
- (void)removeCache
{
    [self.manager removeItemAtPath:CACHE_PATH error:nil];
    
    //创建文件夹
//    BOOL isDir = NO;
//    BOOL existed = [manager fileExistsAtPath:cachePath isDirectory:&isDir];
//    if ( !(isDir == YES && existed == YES) ){
//        [manager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    XSLog(@"%@",CACHE_PATH);
}

+ (void)clearCache
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:CACHE_PATH]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:CACHE_PATH];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[CACHE_PATH stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
//    [[SDImageCache sharedImageCache] cleanDisk];
    
    //创建文件夹
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:CACHE_PATH isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ){
        [fileManager createDirectoryAtPath:CACHE_PATH withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

/** 返回缓存大小字符串 */
+ (NSString *)getCacheSizeFile
{
    NSString *sizeStr = [NSString stringWithContentsOfFile:CACHE_SIZE_PATH encoding:NSUTF8StringEncoding error:nil];
    return sizeStr;
}



@end
