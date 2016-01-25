//
//  PFPictureModel.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/22.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFPictureModel : NSObject<NSCoding>

@property (nonatomic, assign) CGFloat small_width;
@property (nonatomic, assign) CGFloat small_height;
@property (nonatomic, copy) NSString *small_url;
@property (nonatomic, copy) NSString *title;

@property (nonatomic , copy) NSString *image_url;
@property (nonatomic , assign) CGFloat image_width;
@property (nonatomic , assign) CGFloat image_height;

@end
