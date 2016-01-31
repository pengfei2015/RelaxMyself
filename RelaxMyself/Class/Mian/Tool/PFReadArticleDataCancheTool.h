//
//  PFReadArticleDataCancheTool.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/31.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class PFArticleModel;

@interface PFReadArticleDataCancheTool : NSObject

+ (void)saveDataWithArr:(NSArray *)arr idstr:(NSString *)idstr;

+ (void)saveDataWithModel:(PFArticleModel *)model idstr:(NSString *)idstr;

+ (NSArray *)dataWithIdstr:(NSString *)idstr;

+ (void)deleteWithIdstr:(NSString *)idstr;


@end
