//
//  PFMusicProgressView.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/29.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFMusicProgressView;

@protocol PFMusicProgressViewDelegate <NSObject>

@optional

- (void)musicProgressView:(PFMusicProgressView *)progressView progressTapGesture:(UITapGestureRecognizer *)recognizer;

- (void)musicProgressView:(PFMusicProgressView *)progressView slidePanGesture:(UIPanGestureRecognizer *)recognizer;


@end

@interface PFMusicProgressView : UIView

@property (nonatomic, weak) id<PFMusicProgressViewDelegate> delegete;

@property (nonatomic, assign) double downLoadWidth;

@property (nonatomic, assign) double progressWidth;

@property (nonatomic, assign) double currentTime;

@property (nonatomic, assign) double duration;

@property (nonatomic, assign) double slideCurrentX;

@property (nonatomic, assign) double slideMaxX;
@end
