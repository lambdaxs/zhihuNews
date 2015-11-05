//
//  XSToolView.h
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 工具栏高度 */
#define TOOL_H 35

/** 按钮类型的结构体 tag从94开始 */
typedef enum {
    XSPopBtn = 94,
    XSFavoBtn,
    XSDownloadBtn,
    XSComBtn,
    XSShareBtn
}XSToolBtnType;

@class XSToolView;
@protocol XSToolViewDelegate <NSObject>

- (void)toolView:(XSToolView *)view buttonType:(XSToolBtnType)type;

@end

@interface XSToolView : UIView

@property (nonatomic,weak) id<XSToolViewDelegate> delegate;


@end
