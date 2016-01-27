//
//  PFPictureModel.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/22.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFPictureModel.h"

@implementation PFPictureModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _image_height = [aDecoder decodeFloatForKey:@"_image_height"];
        _small_height = [aDecoder decodeFloatForKey:@"_small_height"];
        _image_width = [aDecoder decodeFloatForKey:@"_image_width"];
        _small_width = [aDecoder decodeFloatForKey:@"_small_width"];
        _image_url = [aDecoder decodeObjectForKey:@"_image_url"];
        _small_url = [aDecoder decodeObjectForKey:@"_small_url"];
        
        _title = [aDecoder decodeObjectForKey:@"_title"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_small_url forKey:@"_small_url"];
    [aCoder encodeObject:_image_url forKey:@"_image_url"];
    
    [aCoder encodeFloat:_small_width forKey:@"_small_width"];
    [aCoder encodeFloat:_small_height forKey:@"_small_height"];
    [aCoder encodeFloat:_image_height forKey:@"_image_height"];
    [aCoder encodeFloat:_image_width forKey:@"_image_width"];
    
    [aCoder encodeObject:_title forKey:@"_title"];

}

@end
