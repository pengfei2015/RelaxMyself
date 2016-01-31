//
//  PFReadFooterModel.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadFooterModel.h"

@implementation PFReadFooterModel

- (NSString *)title
{
    if (!_title) {
        _title = [NSString stringWithFormat:@"  %@ · %@", self.name, self.enname];
    }
    return _title;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.enname = [aDecoder decodeObjectForKey:@"enname"];
        self.coverimg = [aDecoder decodeObjectForKey:@"coverimg"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.enname forKey:@"enname"];
    [aCoder encodeObject:self.coverimg forKey:@"coverimg"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.type forKey:@"type"];
}
@end
