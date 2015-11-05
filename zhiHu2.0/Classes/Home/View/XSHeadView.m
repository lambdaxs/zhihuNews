//
//  XSHeadView.m
//  zhiHu2.0
//
//  Created by xiaos on 15/10/19.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSHeadView.h"
#import "NSString+XSDate.h"

@interface XSHeadView ()

@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation XSHeadView

const CGFloat cellHeadViewHeight = 35.0f;

#pragma mark - init
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}

#pragma mark - content
- (void)setDateStr:(NSString *)dateStr {
    _dateStr = dateStr;

    self.dateLabel.text = [NSString dateStrForHeadViewWith:dateStr];
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.dateLabel.frame = self.bounds;
}

#pragma mark - getter & setter
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = RGB(1, 120, 216);
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        [_dateLabel setTextColor:[UIColor whiteColor]];
    }
    return _dateLabel;
}


@end
