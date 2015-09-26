//
//  XSCssFile.h
//  zhihuNews
//
//  Created by xiaos on 15/9/13.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 负责存取网络上下载下来的css文件 */
@interface XSCssFile : NSObject

@property (nonatomic,copy) NSString *url;

/** 存css文件 */
+(void)saveCssFileWithUrl:(NSString *)url;

/** 返回css文件的路径 */
+(NSString *)getPathOfCssFile;

/** 返回旧的css文件url */
+(NSString *)getoOldCssUrl;



@end
