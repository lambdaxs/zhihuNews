//
//  XSTestNet.h
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 三种网络状态 */
typedef enum{
    XSNetNull,
    XSNetWifi,
    XSNetWan,
    XSNetUnkonw
}XSNetState;

@interface XSTestNet : NSObject

+(XSNetState)testNetEnvironment;

@end
