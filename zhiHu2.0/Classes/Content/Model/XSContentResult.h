//
//  XSContentResult.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/26.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSContentResult : NSObject


/** 内容正文 */
@property (nonatomic,copy) NSString *body;
/** 图片来源 */
@property (nonatomic,copy) NSString *image_source;
/** 故事标题 */
@property (nonatomic,copy) NSString *title;
/** 故事图片URL */
@property (nonatomic,copy) NSString *image;
/** 分享URL */
@property (nonatomic,copy) NSString *share_url;
/** web端js数组 */
@property (nonatomic,strong) NSArray *js;
/** 便于谷歌搜索 */
@property (nonatomic,copy) NSString *ga_prefix;
/** 故事id */
@property (nonatomic,copy) NSNumber *id;
/** web端css数组 */
@property (nonatomic,strong) NSArray *css;



@end
