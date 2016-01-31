//
//  PFHerderImageView.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFHerderImageView.h"

@implementation PFHerderImageView

- (void)setUrl:(NSString *)url
{
    NSString *str = [url substringFromIndex:17];
    _url = [str copy];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
