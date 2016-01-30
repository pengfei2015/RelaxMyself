//
//  PFLeftBottonPlayView.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/30.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFLeftBottomPlayView.h"
#import "UIImageView+WebCache.h"
#import "PFMusicModel.h"

@interface PFLeftBottomPlayView ()

{
    UIImageView *_iconView;
    UILabel *_nameLab;
    UIButton *_playButton;
}

@end
@implementation PFLeftBottomPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_nameLab];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"radarPlay"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    CGFloat iconH = self.height;
    CGFloat iconW = iconH;
    CGFloat iconX = margin;
    CGFloat iconY = 0;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    _nameLab.width = 150;
    _nameLab.height = _nameLab.font.lineHeight;
    _nameLab.centerY = self.height * 0.5;
    _nameLab.x = CGRectGetMaxX(_iconView.frame) + margin;
    
    _playButton.size = CGSizeMake(30, 30);
    _playButton.centerY = self.height * 0.5;
    _playButton.x = CGRectGetMaxX(_nameLab.frame);
    
}

- (void)setMusic:(PFMusicModel *)music
{
    _music = music;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:music.pic]];
    _nameLab.text = music.name;
}
@end
