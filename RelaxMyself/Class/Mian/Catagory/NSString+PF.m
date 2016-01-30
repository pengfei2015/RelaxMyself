//
//  NSString+PF.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/29.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "NSString+PF.h"

@implementation NSString (PF)

+ (NSString *)stringWithTime:(NSTimeInterval)time
{
    int minute = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute, second];
}
@end
