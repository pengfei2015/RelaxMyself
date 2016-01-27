//
//  PFMusicCell.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/26.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMusicCell.h"
#import "PFMusicModel.h"
#import "UIImageView+WebCache.h"


@interface PFMusicCell ()

{
    UIImageView *_bgView;
    UIImageView *_iconView;
    UILabel *_titleLab;
    UILabel *_nameLab;
}


@end
@implementation PFMusicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PFMusicCell";
    PFMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PFMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIImageView alloc] init];
        _bgView.alpha = 0.5;
        [self addSubview:_bgView];
        
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
    
        _titleLab = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLab];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    CGFloat bgH = self.height - margin;
    CGFloat bgW = self.width - margin;
    CGFloat bgX = margin;
    CGFloat bgY = margin;
    
    _bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat iconH = self.height - margin;
    CGFloat iconW = iconH;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat titleX = CGRectGetMaxX(_iconView.frame) + margin;
    CGFloat titleY = iconY;
    CGFloat titleW = self.width - margin - titleX;
    CGFloat titleH = self.height * 0.5;
    _titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat nameX = titleX;
    CGFloat nameY = CGRectGetMaxY(_titleLab.frame);
    CGFloat nameW = titleW;
    CGFloat nameH = self.height - nameY;
    _nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);
}
- (void)setMusic:(PFMusicModel *)music
{
    _music = music;
    
    [_bgView sd_setImageWithURL:[NSURL URLWithString:music.pic_1080] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:music.pic] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    _titleLab.text = music.name;
    
    _nameLab.text = music.userName;

}

- (void)drawRect:(CGRect)rect
{
    //self.backgroundView = [UIColor ]
}
@end
