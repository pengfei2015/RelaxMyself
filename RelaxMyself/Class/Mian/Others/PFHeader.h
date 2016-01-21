//
//  PFHeader.h
//  简
//
//  Created by 温鹏飞 on 15/12/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#ifndef __PFHeader_h
#define __PFHeader_h


/**  颜色 */
#define PFRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define PFRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

/**  随机色 */
#define PFRANDRGB PFRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/** 字符转换 */
#define PFFORMAT(...) [NSString stringWithFormat:__VA_ARGS__]

/** 沙盒路径 */
#define PFPATH(path) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:(path)]

/** 普通文本的size */
#define PFTEXTSIZE(str,width,font) [(str) boundingRectWithSize:CGSizeMake((width),MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:(font)} context:nil].size

/** 富文本的size */
#define PFATTRIBUTE_SIZE(str,width) [(str) boundingRectWithSize:CGSizeMake((width),MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size

/** 屏幕的size */
#define PFSCREEN_SIZE [UIScreen mainScreen].bounds.size


// 转换输出函数
#ifdef DEBUG
#define PFLog(...) NSLog(__VA_ARGS__)
#else
#define PFLog(...)
#endif

// 扩展类
#import "UIView+PFExension.h"
#import "UIImage+Extension.h"
#import "UIBarButtonItem+Extension.h"






#endif
