//
//  PFBaseHttpTool.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFBaseHttpTool : NSObject

+ (void)GET:(NSString *)url parameters:(id)model resultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;


+ (void)POST:(NSString *)url parameters:(id)model resultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
@end
