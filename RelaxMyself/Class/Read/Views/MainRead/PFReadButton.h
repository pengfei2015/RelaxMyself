//
//  PFReadButton.h
//  简
//
//  Created by 温鹏飞 on 15/12/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFReadFooterModel;

@interface PFReadButton : UIButton

@property (nonatomic, strong) PFReadFooterModel *footer;
/**
 *  标题名称
 */
@property (nonatomic, copy) NSString * title;


@end
