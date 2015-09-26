//
//  XSStories.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/23.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSStories : NSObject

//"title":"只想去个人少景美的地方，安安静静待一周",
//"ga_prefix":"092320",
//"images":[
//          "http://pic3.zhimg.com/92b4c38fb9ec9834da7250a98b820d46.jpg"
//          ],
//"multipic":true,
//"type":0,
//"id":7117730

/** 故事标题 */
@property (nonatomic,copy) NSString *title;
/** 便于谷歌识别 */
@property (nonatomic,copy) NSString *ga_prefix;
/** 故事图片数组 */
@property (nonatomic,strong) NSArray *images;
/** 未知属性 */
@property (nonatomic,assign) NSString *multipic;
/** 故事类型 */
@property (nonatomic,copy) NSString *type;
/** 故事id */
@property (nonatomic,copy) NSNumber *id;



@end
