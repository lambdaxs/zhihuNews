//
//  XSHeadView.h
//  zhiHu2.0
//
//  Created by xiaos on 15/10/19.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XSHeadView : UITableViewHeaderFooterView
/** cell头视图高度 */
extern const CGFloat cellHeadViewHeight;

/** 标题日期 */
@property (nonatomic,copy) NSString *dateStr;

@end
