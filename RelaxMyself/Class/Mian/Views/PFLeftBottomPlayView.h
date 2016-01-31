//
//  PFLeftBottonPlayView.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/30.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFMusicModel,DOUAudioStreamer;

@interface PFLeftBottomPlayView : UIView

@property (nonatomic, strong) PFMusicModel *music;
@property (nonatomic, strong) DOUAudioStreamer *streamer;
@end
