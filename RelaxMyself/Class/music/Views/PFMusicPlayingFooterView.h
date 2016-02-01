//
//  PFMusicPlayingFooterView.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/26.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PFMusicPlayButtonType) {
    PFMusicPlayButtonTypePrevious,
    PFMusicPlayButtonTypePlay,
    PFMusicPlayButtonTypeNext
};

@class PFMusicPlayingFooterView;

@protocol PFMusicPlayingFooterViewDelegate <NSObject>

@optional
- (void)musicPlayingFooterView:(PFMusicPlayingFooterView *)footerView buttonTypeClick:(PFMusicPlayButtonType)type;

- (void)musicPlayingFooterView:(PFMusicPlayingFooterView *)footerView voiceValueChange:(CGFloat)value;
@end


@interface PFMusicPlayingFooterView : UIView

@property (nonatomic, weak) id<PFMusicPlayingFooterViewDelegate> delegate;
@property (nonatomic, strong) UISlider *slider;
@end
