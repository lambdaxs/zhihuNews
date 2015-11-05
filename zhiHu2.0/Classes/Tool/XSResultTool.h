//
//  XSResultTool.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSResult.h"

@interface XSResultTool : NSObject
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>启动图片请求
+ (void)getLaunchImageURLForSuccess:(void (^)(NSString *imageURL))success failure:(void (^)(NSError *error))failure;

// >>>>>>>>>>>>>>>>>>>>首页控制器的业务请求

/** 获取最新故事的请求 */
+ (void)getNewDictForSuccess:(void (^)(XSResult *result))success failure:(void (^)(NSError *error))failure;

/** 根据dateStr获取旧故事的请求 */
+ (void)getOldDictWithDateStr:(NSString *)dateStr forSuccess:(void (^)(XSResult *result))success failure:(void (^)(NSError *error))failure;

// >>>>>>>>>>>>>>>>>>>>内容控制器的业务请求

/** 根据stoiresID获取故事内容的请求 */
+ (void)getStoriesContentWithStoiresId:(NSString *)stoiresId forSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure;

#warning mark - 抽取出一个缓存工具类专门负责数据缓存
/** 根据stoiresID获取故事内容的缓存 */
+ (NSString *)getHtmlStrWithResponse:(id)responseObject;



@end
