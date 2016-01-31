//
//  PFMusicModel.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/25.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMusicModel.h"

@implementation PFMusicModel

- (void)setUser:(NSDictionary *)user
{
    _user = [user copy];
    _userName = user[@"name"];
}

//- (void)setSource:(NSString *)source
//{
//    _source = [source copy];
//    _audioFileURL = [NSURL URLWithString:source];
//}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {

        self.pic = [aDecoder decodeObjectForKey:@"pic"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.pic_1080 = [aDecoder decodeObjectForKey:@"pic_1080"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        //self.audioFileURL = [aDecoder decodeObjectForKey:@"audioFileURL"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.pic forKey:@"pic"];
    [aCoder encodeObject:self.pic_1080 forKey:@"pic_1080"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.id forKey:@"id"];
    //[aCoder encodeObject:self.audioFileURL forKey:@"audioFileURL"];
    
}

@end
