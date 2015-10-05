//
//  XSResultTool.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSResult.h"

@interface XSResultTool : NSObject

/** 每次请求内容时 传人的故事id */
@property (nonatomic,copy) NSString *stoiresId;

/** 每次下拉加载时 传入对应的日期字符串 e.g. 20150927 */
@property (nonatomic,copy) NSString *dateStr;

// >>>>>>>>>>>>>>>>>>>>首页控制器的业务请求

/** 获取最新故事的请求 */
+ (void)getNewDictForSuccess:(void (^)(XSResult *result))success failure:(void (^)(NSError *error))failure;

/** 获取旧故事的请求 */
- (void)getOldDictForSuccess:(void (^)(XSResult *result))success failure:(void (^)(NSError *error))failure;


// >>>>>>>>>>>>>>>>>>>>内容控制器的业务请求

/** 获取故事内容的请求 */
- (void)getStoriesContentWithSuccess:(void (^)(NSString *htmlStr))success failure:(void (^)(NSError *error))failure;


@end
