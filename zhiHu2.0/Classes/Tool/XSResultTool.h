//
//  XSResultTool.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSResultTool : NSObject

+ (void)getNewStoriesForSuccess:(void (^)(NSArray *storiesArray,NSArray *topStoriesArray))success failure:(void (^)(NSError *error))failure;

@end
