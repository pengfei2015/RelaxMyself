//
//  PFReadHttpTool.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFBaseHttpTool.h"
#import "PFReadDetailRequest.h"
#import "PFReadDataModel.h"
#import "PFReadHeaderAticleRequest.h"
#import "PFArticleModel.h"
#import "PFReadDetailModel.h"

@interface PFReadHttpTool : PFBaseHttpTool

/**
 *  阅读首页头部文章信息
 */

+ (void)readDetailWithParameter:(PFReadHeaderAticleRequest *)parame success:(void(^)(PFArticleModel *result))success failure:(void(^)(NSError *error))failure;

/**
 *  阅读首页按钮图片信息
 */
+ (void)readDetailWithParameterSuccess:(void(^)(PFReadDataModel *result))success failure:(void(^)(NSError *error))failure;

/**
 *  阅读详情列表的数据
 */
+ (void)readDetailListWithUrl:(NSString *)url parameter:(PFReadDetailRequest *)parame success:(void(^)(PFReadDetailModel *result))success failure:(void(^)(NSError *error))failure;
@end
