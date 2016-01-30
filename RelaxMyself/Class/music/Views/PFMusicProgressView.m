//
//  PFMusicProgressView.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/29.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMusicProgressView.h"

@interface PFMusicProgressView ()
{
    UIView *_downLoadView;
    UIView *_progressView;
    UIButton *_slideButton;
    UILabel *_timeLab;
    UILabel *_popLab;
}
@end
@implementation PFMusicProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = PFRGBA(255, 255, 255, 0.5);
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressTap:)];
        [self addGestureRecognizer:recognizer];
        
        UIView *downLoadView = [[UIView alloc] init];
        downLoadView.backgroundColor = [UIColor redColor];
        [self addSubview:downLoadView];
        _downLoadView = downLoadView;
        
        UIView *progressView = [[UIView alloc] init];
        progressView.backgroundColor = [UIColor blueColor];
        [self addSubview:progressView];
        _progressView = progressView;
        
        
        UILabel *timeLab = [[UILabel alloc] init];
        timeLab.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:timeLab];
        _timeLab = timeLab;
        
        UIButton *slideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [slideButton setBackgroundImage:[UIImage imageNamed:@"process_thumb"] forState:UIControlStateNormal];
        slideButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [slideButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        slideButton.adjustsImageWhenHighlighted = NO;
        [self addSubview:slideButton];
        _slideButton = slideButton;
        
        UIPanGestureRecognizer *slideRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideButtonPan:)];
        [slideButton addGestureRecognizer:slideRecognizer];
        
        UILabel *popLab = [[UILabel alloc] init];
        [self addSubview:popLab];
        _popLab = popLab;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _slideButton.size = CGSizeMake(42, self.height * 2);
    _slideButton.centerY = self.height * 0.5;

    CGFloat timeW = 42;
    CGFloat timeH = self.height;
    CGFloat timeY = 0;
    CGFloat timeX = self.width - timeW;
    _timeLab.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    _popLab.frame = CGRectMake(0, -50, 42, 25);
    
}


#pragma mark -- 手势点击

- (void)progressTap:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegete respondsToSelector:@selector(musicProgressView:progressTapGesture:)]) {
        [self.delegete musicProgressView:self progressTapGesture:recognizer];
    }
    
}

- (void)slideButtonPan:(UIPanGestureRecognizer *)recognizer
{
    if ([self.delegete respondsToSelector:@selector(musicProgressView:slidePanGesture:)]) {
        [self.delegete musicProgressView:self slidePanGesture:recognizer];
    }
}

#pragma mark -- 公共方法

- (double)slideMaxX
{
    return self.width - _slideButton.width;
}

- (void)setSlideCurrentX:(double)slideCurrentX
{
    _slideCurrentX = slideCurrentX;
    _slideButton.x = slideCurrentX;
}

- (void)setProgressWidth:(double)progressWidth
{
    _progressWidth = progressWidth;
    
    _progressView.frame = CGRectMake(0, 0, progressWidth + 20, self.height);
    
}



- (void)setCurrentTime:(double)currentTime
{
    _currentTime = currentTime;
    [_slideButton setTitle:[NSString stringWithTime:currentTime] forState:UIControlStateNormal];

}

- (void)setDuration:(double)duration
{
    _duration = duration;

    _timeLab.text = [NSString stringWithTime:duration];
}
- (void)setDownLoadWidth:(double)downLoadWidth
{
    _downLoadWidth = downLoadWidth;
    _downLoadView.frame = CGRectMake(0, 0, downLoadWidth, self.height);
}
@end
