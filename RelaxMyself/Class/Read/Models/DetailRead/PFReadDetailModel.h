//
//  PFDetailModel.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFReadDetailModel : NSObject<NSCoding>

@property (nonatomic, strong) NSDictionary *columnsInfo;
/**
 *  列表内容
 */
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger total;





@end
