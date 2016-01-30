//
//  PFMusicPlayingFooterView.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/26.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMusicPlayingFooterView.h"

@interface PFMusicPlayingFooterView ()

{
    UIButton *_playButton;
    UIButton *_nextButton;
    UIButton *_previousButon;
    
    BOOL _isPause;
}

@end
@implementation PFMusicPlayingFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.tag = PFMusicPlayButtonTypePlay;
        [_playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playButton];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.tag = PFMusicPlayButtonTypeNext;
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextButton];
        
        _previousButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previousButon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _previousButon.tag = PFMusicPlayButtonTypePrevious;
        [_previousButon setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
        [self addSubview:_previousButon];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 0;
    
    CGFloat playW = 72.0;
    CGFloat playH = 46.0;
    CGFloat playCenterX = self.width * 0.5;
    CGFloat playCenterY = self.height * 0.5;
    _playButton.size = CGSizeMake(playW, playH);
    _playButton.center = CGPointMake(playCenterX, playCenterY);
    
    _previousButon.size = CGSizeMake(42.0, 46.0);
    _previousButon.centerY = _playButton.centerY;
    _previousButon.x = CGRectGetMinX(_playButton.frame) - margin - _previousButon.width;
    
    _nextButton.size = CGSizeMake(42.0, 46.0);
    _nextButton.centerY = _playButton.centerY;
    _nextButton.x = CGRectGetMaxX(_playButton.frame) + margin ;
}

- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(musicPlayingFooterView:buttonTypeClick:)]) {
        if (PFMusicPlayButtonTypeNext == button.tag || PFMusicPlayButtonTypePrevious == button.tag) {
            [_playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            _isPause = YES;
        }else{
            if (_isPause) {
                [_playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                _isPause = NO;
            }else{
                [_playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
                _isPause = YES;
            }
        }
        [self.delegate musicPlayingFooterView:self buttonTypeClick:button.tag];
    }
}

- (void)setDelegate:(id<PFMusicPlayingFooterViewDelegate>)delegate
{
    _delegate = delegate;
    [self buttonClick:_playButton];
}

@end
