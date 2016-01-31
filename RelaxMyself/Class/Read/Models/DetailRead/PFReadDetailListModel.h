//
//  PFReadDetailListModel.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFReadDetailListModel : NSObject<NSCoding>

/**
 *  列表的内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  列表图片网址
 */
@property (nonatomic, copy) NSString *coverimg;
/**
 *  列表的名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  列表的标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  列表的id
 */
@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *headerId;


// 补充的最后一个的列表信息
@property (nonatomic, copy) NSString *shortcontent;

@property (nonatomic, copy) NSString *firstimage;

@property (nonatomic, copy) NSString *contentid;

@end
