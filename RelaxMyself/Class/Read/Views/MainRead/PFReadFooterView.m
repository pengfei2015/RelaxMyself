//
//  PFFooterView.m
//  简
//
//  Created by 温鹏飞 on 15/12/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadFooterView.h"
#import "PFReadFooterModel.h"
#import "UIButton+WebCache.h"
#import "PFReadViewController.h"


@interface PFReadFooterView ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) PFReadButton *footerButton;


@end
@implementation PFReadFooterView

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加九宫格布局的按钮
        for (int i = 0; i < 9; ++i) {
            PFReadButton *button = [[PFReadButton alloc] init];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [self.buttons addObject:button];
        }

        PFReadButton *footerButton = [[PFReadButton alloc] init];
        [footerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:footerButton];
        self.footerButton = footerButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    
    for (int i = 0; i < self.buttons.count; ++i) {
        UIButton *btn = self.buttons[i];
        
        NSInteger maxColums = 3;
        
        CGFloat btnW = (self.width - (maxColums + 1) * margin) / maxColums;
        CGFloat btnH = btnW;
        CGFloat btnX = margin + (i % maxColums) * (margin + btnW);
        CGFloat btnY = margin + i / maxColums * (margin + btnH);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
     
    }
    
    UIButton *lastButton = [self.buttons lastObject];
    
    CGFloat footerX = margin;
    CGFloat footerY = CGRectGetMaxY(lastButton.frame) + margin;
    CGFloat footerW = self.width - 2 * margin;
    CGFloat footerH = lastButton.height;
    self.footerButton.frame = CGRectMake(footerX, footerY, footerW, footerH);
    
    self.height = CGRectGetMaxY(self.footerButton.frame) + margin;

}

- (void)setFooters:(NSArray *)footers
{
    _footers = footers;
    for (int i = 0; i < self.buttons.count; ++i) {
        PFReadFooterModel *footer = _footers[i];
        PFReadButton *button = self.buttons[i];
        button.footer = footer;
    }
    
    PFReadFooterModel *footer = [[PFReadFooterModel alloc] init];
    footer.name = @"24 小时写作";
    footer.title = @"  24 小时写作·New Writing.";
    footer.type = PFREAD_FOOTER_TYPE;
    self.footerButton.footer = footer;
    
    [self.footerButton setBackgroundImage:[UIImage imageNamed: @"bomimg.jpg"] forState:UIControlStateNormal];
}


- (void)buttonClick:(PFReadButton *)button
{
    if ([self.footerDelegate respondsToSelector:@selector(footerView:buttonClick:)]) {
        [self.footerDelegate footerView:self buttonClick:button];
    }
}

@end
