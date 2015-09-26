//
//  XSContentResult.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/26.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSContentResult : NSObject

//"image_source":"its all about Rock (: / CC BY",
//"title":"闭上眼，你能想象斑马有多少条纹吗？",
//"image":"http://pic1.zhimg.com/1381270ddcec39e17d703878afe57e5c.jpg",
//"share_url":"http://daily.zhihu.com/story/7125813",
//"js":[
//      "http://news.at.zhihu.com/js/story.js?v=/js/story.js"
//      ],
//"ga_prefix":"092413",
//"type":0,
//"id":7125813,
//"css":[
//       "http://news.at.zhihu.com/css/news_qa.auto.css?v=77778"
//       ]
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
