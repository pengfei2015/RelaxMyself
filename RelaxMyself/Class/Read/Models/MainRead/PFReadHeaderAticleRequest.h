//
//  PFReadHeaderAticleRequest.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFReadHeaderAticleRequest : NSObject
/**
 *  图片附带的网址 NSString
 */
@property (nonatomic, copy) NSString * contentid;

/**
 *  数值是 2 int
 */
@property (nonatomic, assign) NSInteger client;

@end
