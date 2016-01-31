//
//  PFReadDetailListModel.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadDetailListModel.h"

@implementation PFReadDetailListModel

- (void)setId:(NSString *)id
{
    _id = [id copy];
    
    _headerId = [_id substringFromIndex:17];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.coverimg = [aDecoder decodeObjectForKey:@"coverimg"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.shortcontent = [aDecoder decodeObjectForKey:@"shortcontent"];
        self.firstimage = [aDecoder decodeObjectForKey:@"firstimage"];
        self.contentid = [aDecoder decodeObjectForKey:@"contentid"];

        self.id = [aDecoder decodeObjectForKey:@"id"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.coverimg forKey:@"coverimg"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.shortcontent forKey:@"shortcontent"];
    [aCoder encodeObject:self.contentid forKey:@"contentid"];
    [aCoder encodeObject:self.firstimage forKey:@"firstimage"];
    [aCoder encodeObject:self.id forKey:@"id"];
}


@end
