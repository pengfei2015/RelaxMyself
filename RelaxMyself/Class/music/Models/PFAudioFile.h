//
//  PFAudioFile.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/27.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioStreamer.h"

@interface PFAudioFile : NSObject<DOUAudioFile>

@property (nonatomic, strong) NSURL *audioFileURL;

@end
