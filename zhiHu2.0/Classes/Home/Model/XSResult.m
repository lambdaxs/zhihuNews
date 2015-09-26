//
//  XSResult.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSResult.h"
#import "XSStories.h"
#import "XSTopStories.h"

@implementation XSResult

/** 转换数组中的模型 */
+(NSDictionary *)objectClassInArray
{
    return @{@"stories":[XSStories class],@"top_stories":[XSTopStories class]};
}

@end
