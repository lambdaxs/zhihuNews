//
//  XSToolView.h
//  zhihuNews
//
//  Created by xiaos on 15/9/15.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSToolView;
@protocol XSToolViewDelegate <NSObject>

-(void)toolView:(XSToolView *)view;

@end
@interface XSToolView : UIView

+(instancetype)sharedInstance;

@property (nonatomic,weak) id<XSToolViewDelegate> delegate;


@end
