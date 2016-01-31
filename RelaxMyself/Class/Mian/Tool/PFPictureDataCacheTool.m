//
//  PFPictureDataCache.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/25.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFPictureDataCacheTool.h"
#import "PFPictureModel.h"

@implementation PFPictureDataCacheTool

static FMDatabaseQueue *_queue;

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.sqlite"];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 建表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS picture (ID integer PRIMARY KEY AUTOINCREMENT, data blob, idstr text)"];
        if (!result) {
            PFLog(@"建表失败");
        }else{
            PFLog(@"建表成功");
        }
    }];
    
}


+ (void)saveDataWithArr:(NSArray *)arr idstr:(NSString *)idstr
{
    [self deleteWithIdstr:idstr];
    
    for (PFPictureModel *model in arr) {
        [self saveDataWithModel:model idstr:idstr];
    }
}

+ (void)saveDataWithModel:(PFPictureModel *)model idstr:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [db executeUpdate:@"INSERT INTO picture(data,idstr) VALUES(?,?)",data,idstr];
    }];
}
+ (NSArray *)dataWithIdstr:(NSString *)idstr
{
    __block NSMutableArray *arr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM picture WHERE idstr = ?",idstr];
        if (result) {
            while ([result next]) {
                NSData *data = [result dataForColumn:@"data"];
                PFPictureModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:model];
            }
        }
    }];
    return arr;
}

+ (void)deleteWithIdstr:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"DELETE FROM picture WHERE idstr = ?",idstr];
        if (!result) {
            PFLog(@"删除失败");
        }
    }];
}
@end
