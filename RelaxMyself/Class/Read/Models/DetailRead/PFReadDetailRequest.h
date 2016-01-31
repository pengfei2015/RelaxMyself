//
//  PFReadDetailRequest.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PFReadDetailRequest : NSObject

/**
 *  int 一次请求多少数据
 */
@property (nonatomic, assign) int limit;
/**
 *  栏目信息请求  hot || addtime
 */
@property (nonatomic, copy) NSString *sort;

/**
 *  int 请求数据的类型
 */
@property (nonatomic, assign) NSInteger typeid;

/**
 *  请求数据的起始位置
 */
@property (nonatomic, assign) NSUInteger start;

@end
