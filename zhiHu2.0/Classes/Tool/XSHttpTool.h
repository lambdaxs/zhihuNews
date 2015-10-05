//
//  XSHttpTool.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//
/** 封装AFN的网络请求 */

#import <Foundation/Foundation.h>

@interface XSHttpTool : NSObject

/** 封装GET请求 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/** 封装POST请求 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
