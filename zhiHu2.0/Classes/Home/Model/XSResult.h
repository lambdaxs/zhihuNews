//
//  XSResult.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface XSResult : NSObject<MJKeyValue>

/** 当天日期 */
@property (nonatomic,copy) NSString *date;
/** 故事数组 */
@property (nonatomic,strong) NSArray *stories;
/** 顶部故事数组 */
@property (nonatomic,strong) NSArray *top_stories;

@end
