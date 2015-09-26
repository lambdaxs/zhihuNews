//
//  XSSetting.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSSetting.h"

@implementation XSSetting

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)settingWithPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"setting.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    XSSetting *model = [[self alloc] initWithDic:dict];
    return model;
}

@end
