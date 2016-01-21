//
//  PFLeftButton.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFLeftCell.h"


@interface PFLeftCell ()

@end
@implementation PFLeftCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PFLeftCell";
    PFLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PFLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        _iconView = iconView;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:titleLab];
        _titleLab = titleLab;
    
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 20;
    
    CGFloat iconH = _titleLab.font.lineHeight;
    CGFloat iconW = iconH;
    CGFloat iconX = margin;
    CGFloat iconY = 0.5 * (self.height - iconH);
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat titleW = self.width - CGRectGetMaxX(_iconView.frame) - margin;
    CGFloat titleH = iconH;
    CGFloat titleX = CGRectGetMaxX(_iconView.frame) + margin;
    CGFloat titleY = iconY;
    _titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}
@end
