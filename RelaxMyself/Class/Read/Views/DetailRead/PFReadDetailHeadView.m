//
//  PFReadDetailHeadView.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadDetailHeadView.h"

@interface PFReadDetailHeadView()

@property (nonatomic, weak) UIButton *aButton;
@property (nonatomic, weak) UIButton *bButton;

@end
@implementation PFReadDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
        newButton.tag = mostNew;
        [newButton setTitle:@"最新" forState:UIControlStateNormal];
        [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newButton addTarget:self action:@selector(headViewCilck:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:newButton];
        self.aButton = newButton;
        
        UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        hotButton.tag = mostHot;
        [hotButton setTitle:@"最热" forState:UIControlStateNormal];
        [hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [hotButton addTarget:self action:@selector(headViewCilck:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hotButton];
        self.bButton = hotButton;

    }
    return self;
}

- (void)layoutSubviews
{
    //[super layoutSubviews];
    
    
    CGSize size = [self.aButton.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.aButton.titleLabel.font} context:nil].size;

    self.aButton.size = size;
    self.aButton.center = CGPointMake(self.width / 3, self.height * 0.5);
    self.bButton.size = size;
    self.bButton.center = CGPointMake(self.width / 3 * 2, self.height * 0.5);
 
}

- (void)headViewCilck:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(readDetailViewHeadView:buttonClick:)]) {
        [self.delegate readDetailViewHeadView:self buttonClick:button.tag];
    }
}
@end
