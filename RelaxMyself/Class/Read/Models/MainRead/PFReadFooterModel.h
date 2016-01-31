//
//  PFReadFooterModel.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFReadFooterModel : NSObject<NSCoding>

/**
 *  图片网址
 */
@property (nonatomic, copy) NSString * coverimg;

/**
 *  标题后缀
 */
@property (nonatomic, copy) NSString * enname;

/**
 *  标题名字
 */
@property (nonatomic, copy) NSString * name;

@property (nonatomic, assign) NSInteger type;

/**
 *  完整标题名字
 */
@property (nonatomic, copy) NSString * title;

@end
