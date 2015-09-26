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
#define margin 10.0
/** 图片宽度 */
#define imgWidth 65.0
/** 图片高度 */
#define imgHight 65.0

@interface XSStoriesCell ()

/** 故事图片视图 */
@property (nonatomic,weak) UIImageView *storiesImage;
/** 故事标题视图 */
@property (nonatomic,weak) UILabel *storiesTitle;

@end

@implementation XSStoriesCell

#pragma mark - override
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0].CGColor);
    CGContextStrokeRect(context, CGRectMake(margin, rect.size.height, rect.size.width - 2*margin, margin));
}

#pragma mark - get customCell
+(instancetype)storiesCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"stories";
    XSStoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.height = cellHight;
    return cell;
}

#pragma mark - override initWithStyle  && 初始化子控件
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgV = [[UIImageView alloc] init];
        [self.contentView addSubview:imgV];
        _storiesImage = imgV;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        titleLabel.numberOfLines = 0;
//        [titleLabel sizeToFit];
        [self.contentView addSubview:titleLabel];
        _storiesTitle = titleLabel;
    }
    return self;
}

#pragma mark - 为子控件赋值
-(void)setStoriesModel:(XSStories *)storiesModel
{
    _storiesModel = storiesModel;
    
    NSString *imgStr = _storiesModel.images[0];
    NSURL *imgURL = [NSURL URLWithString:imgStr];
    [_storiesImage sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.storiesTitle.text = _storiesModel.title;
}

#pragma mark - 为子控件布局
-(void)layoutSubviews
{
    CGFloat imgX = margin;
    CGFloat imgY = margin;
    CGFloat imgW = imgWidth;
    CGFloat imgH = imgHight;
    
    _storiesImage.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleX = imgWidth + 2*margin;
    CGFloat titleY = 0;
    CGFloat titleW = self.contentView.width - (imgWidth + 3*margin);
    CGFloat titleH = self.contentView.height - 2*margin;
    
    _storiesTitle.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end
