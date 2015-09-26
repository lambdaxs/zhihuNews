//
//  XSTestNet.m
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSTestNet.h"

#import "Reachability.h"
#import "MBProgressHUD+Extend.h"


@implementation XSTestNet

/** 测试网络环境（抽取到工具类） */
+(XSNetState)testNetEnvironment
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"baidu.com"];
    
    dispatch_after(3, dispatch_get_main_queue(), ^{
        if (reach.currentReachabilityStatus == NotReachable) {
            [MBProgressHUD showError:@"网络连接不稳定"];
        }
    });
    
    switch (reach.currentReachabilityStatus) {
        case NotReachable:
            [MBProgressHUD showError:@"无网络连接"];
            return XSNetNull;
        case ReachableViaWiFi:
            NSLog(@"use wifi");
            return XSNetWifi;
        case ReachableViaWWAN:
            NSLog(@"use wan");
            return XSNetWan;
    }
    
}

@end
