//
//  XSStoriesCell.h
//  zhiHu2.0
//
//  Created by xiaos on 15/9/24.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>

/** cell高度 */
extern const CGFloat cellHeight;

@class XSStories;
@interface XSStoriesCell : UITableViewCell

/** cell中的故事模型 */
@property (nonatomic,strong) XSStories *storiesModel;

@end
