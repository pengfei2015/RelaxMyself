//
//  PFReadDeitailDataCacheTool.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/31.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class PFReadDetailListModel;

@interface PFReadDeitailDataCacheTool : NSObject

+ (void)saveDataWithArr:(NSArray *)arr idstr:(NSString *)idstr;

+ (void)saveDataWithModel:(PFReadDetailListModel *)model idstr:(NSString *)idstr;

+ (NSArray *)dataWithIdstr:(NSString *)idstr;

+ (void)deleteWithIdstr:(NSString *)idstr;

@end
