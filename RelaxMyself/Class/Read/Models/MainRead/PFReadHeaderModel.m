//
//  PFReadHeaderModel.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadHeaderModel.h"

@implementation PFReadHeaderModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.url = [aDecoder decodeObjectForKey:@"url"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.url forKey:@"url"];
}

@end
