//
//  PFBaseHttpTool.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFBaseHttpTool.h"
#import "MJExtension.h"
#import "PFReadRespondModel.h"
#import "AFNetworking.h"


@implementation PFBaseHttpTool

+ (void)POST:(NSString *)url parameters:(id)model resultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameter = [model keyValues];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        PFReadRespondModel *respond = [PFReadRespondModel objectWithKeyValues:dict];
        id result = [resultClass objectWithKeyValues:respond.data];
        if (success) {
            success(result);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
}


+ (void)GET:(NSString *)url parameters:(id)model resultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameter = [model keyValues];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        PFReadRespondModel *respond = [PFReadRespondModel objectWithKeyValues:dict];
        id result = [resultClass objectWithKeyValues:respond.data];
        if (success) {
            success(result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];}


@end
