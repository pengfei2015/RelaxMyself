//
//  PFReadHeaderModel.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFReadHeaderModel : NSObject<NSCoding>

/**
 *  图片地址
 */
@property (nonatomic, copy) NSString * img;
/**
 *  网址
 */
@property (nonatomic, copy) NSString * url;

@end
