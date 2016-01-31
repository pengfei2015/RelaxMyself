//
//  PFReadData.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFReadDataModel : NSObject<NSCoding>

/**
 *  头部头像数据数组
 */
@property (nonatomic, strong) NSArray *carousel;

/**
 *  九宫格数据数组
 */
@property (nonatomic, strong) NSArray *list;

@end
