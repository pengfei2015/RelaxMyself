//
//  PFLeftBottonPlayView.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/30.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFMusicModel,PFLeftBottomPlayView;

@protocol PFLeftBottomPlayViewDelegate <NSObject>

#warning 待续
@optional
- (void)leftBottomView:(PFLeftBottomPlayView *)bottomView buttonClick:(UIButton *)button;

@end
@interface PFLeftBottomPlayView : UIView

@property (nonatomic, strong) PFMusicModel *music;
@end
