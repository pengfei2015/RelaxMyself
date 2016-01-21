//
//  UIBarButtonItem+Extension.h
//  鹏飞新闻
//
//  Created by 王家辉 on 15/12/6.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
@end
