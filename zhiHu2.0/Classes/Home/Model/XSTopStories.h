//
//  XSTopStories.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSTopStories : NSObject

//"image":"http://pic4.zhimg.com/94c7cdace010c0f4a6dc68a397e45f17.jpg",
//"type":0,
//"id":7117730,
//"ga_prefix":"092320",
//"title":"只想去个人少景美的地方，安安静静待一周"

/** 顶部故事图片的URL */
@property (nonatomic,copy) NSString *image;
/** 顶部故事类型 */
@property (nonatomic,copy) NSString *type;
/** 顶部故事的id */
@property (nonatomic,copy) NSNumber *id;
/** 便于谷歌查找 */
@property (nonatomic,copy) NSString *ga_prefix;
/** 顶部故事标题 */
@property (nonatomic,copy) NSString *title;

@end
