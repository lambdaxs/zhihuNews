//
//  XSSetting.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSSetting : NSObject

@property (nonatomic,strong) NSArray *setting;

@property (nonatomic,strong) NSArray *about;

+ (instancetype)settingWithPlist;


@end
