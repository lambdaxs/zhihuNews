//
//  XSStoriesCell.m
//  zhiHu2.0
//
//  Created by xiaos on 15/9/24.
//  Copyright (c) 2015年 com.xsdota. All rights reserved.
//

#import "XSStoriesCell.h"

#import "XSStories.h"

#import "UIImageView+WebCache.h"


/** 图片文字边距间隔 */
static const CGFloat margin = 10.0f;
/** 图片宽度 */
static const CGFloat imgWidth = 65.0f;
/** 图片高度 */
static const CGFloat imgHight = 65.0f;
/** cell分割线宽度 */
static const CGFloat cellLineWidth = 0.8f;
/** cell的高度 */
const CGFloat cellHeight = 85.0f;


@interface XSStoriesCell ()
/** 故事图片 */
@property (nonatomic,strong) UIImageView *storiesImage;
/** 故事标题 */
@property (nonatomic,strong) UILabel *storiesTitle;

@end

@implementation XSStoriesCell

#pragma mark -  init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.height = cellHeight;
        [self.contentView addSubview:self.storiesImage];
        [self.contentView addSubview:self.storiesTitle];
    }
    return self;
}

#pragma mark - content
- (void)setStoriesModel:(XSStories *)storiesModel
{
    _storiesModel = storiesModel;
    
    self.storiesTitle.text = storiesModel.title;
    
    NSString *imgStr = _storiesModel.images[0];
    NSURL *imgURL = [NSURL URLWithString:imgStr];
    [self.storiesImage sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

#pragma mark - layout
-(void)layoutSubviews
{
    CGFloat imgX = margin;
    CGFloat imgY = margin;
    CGFloat imgW = imgWidth;
    CGFloat imgH = imgHight;
    self.storiesImage.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleX = imgWidth + 2*margin;
    CGFloat titleY = 0;
    CGFloat titleW = self.contentView.width - (imgWidth + 3*margin);
    CGFloat titleH = self.contentView.height - 2*margin;
    self.storiesTitle.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark - getter & setter
-(UIImageView *)storiesImage
{
    if (!_storiesImage) {
        _storiesImage = [[UIImageView alloc] init];
    }
    return _storiesImage;
}

-(UILabel *)storiesTitle
{
    if (!_storiesTitle) {
        _storiesTitle = [[UILabel alloc] init];
        _storiesTitle.font = [UIFont systemFontOfSize:16.0f weight:0.5f];
        _storiesTitle.numberOfLines = 0;
    }
    return _storiesTitle;
}

#pragma mark - drawRect
- (void)drawRect:(CGRect)rect {
    
    //画cell下方的分割线
    [RGB(225, 225, 225) set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = cellLineWidth;
    [path moveToPoint:CGPointMake(margin, rect.size.height - cellLineWidth)];
    [path addLineToPoint:CGPointMake(rect.size.width - margin, rect.size.height - cellLineWidth)];
    [path stroke];
}

@end
