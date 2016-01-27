//
//  PFMusicDataCacheTool.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/26.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFMusicModel;

@interface PFMusicDataCacheTool : NSObject

+ (void)saveDataWithArr:(NSArray *)arr idstr:(NSString *)idstr;

+ (void)saveDataWithModel:(PFMusicModel *)model idstr:(NSString *)idstr;

+ (NSArray *)dataWithIdstr:(NSString *)idstr;

+ (void)deleteWithIdstr:(NSString *)idstr;

@end
