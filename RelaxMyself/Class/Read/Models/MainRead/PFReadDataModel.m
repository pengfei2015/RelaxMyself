//
//  PFReadData.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadDataModel.h"
#import "MJExtension.h"
#import "PFReadFooterModel.h"
#import "PFReadHeaderModel.h"

@implementation PFReadDataModel

- (NSDictionary *)objectClassInArray
{
    return @{@"list" : [PFReadFooterModel class], @"carousel" : [PFReadHeaderModel class]};
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.list = [aDecoder decodeObjectForKey:@"list"];
        self.carousel = [aDecoder decodeObjectForKey:@"carousel"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.list forKey:@"list"];
    [aCoder encodeObject:self.carousel forKey:@"carousel"];
}
@end
