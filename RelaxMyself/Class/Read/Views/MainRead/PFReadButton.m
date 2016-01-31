//
//  PFReadButton.m
//  简
//
//  Created by 温鹏飞 on 15/12/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadButton.h"
#import "PFReadFooterModel.h"
#import "UIButton+WebCache.h"

@interface PFReadButton ()
@property (nonatomic, weak) UILabel *titleLab;

@end
@implementation PFReadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        self.adjustsImageWhenHighlighted = NO;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.backgroundColor = PFRGBA(0, 0, 0, 0.4);
        titleLab.font = [UIFont systemFontOfSize:11.0];
        titleLab.textColor = [UIColor whiteColor];
        
        [self addSubview:titleLab];
        self.titleLab= titleLab;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleW = self.width;
    CGFloat titleH = 20;
    CGFloat titleX = 0;
    CGFloat titleY = self.height - titleH;
    
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (void)setFooter:(PFReadFooterModel *)footer
{
    _footer = footer;
    
    self.titleLab.text = _footer.title;
    
    NSString *name = _footer.coverimg;
    [self setBackgroundImageWithURL:[NSURL URLWithString:name] forState:UIControlStateNormal];
    self.tag = _footer.type;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLab.text = title;
}

@end
