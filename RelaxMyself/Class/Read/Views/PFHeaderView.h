//
//  PFHeaderView.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFHerderImageView.h"

@class PFHeaderView,PFHerderImageView;

@protocol PFHeaderViewDelegate <NSObject>

@optional

- (void)headerView:(PFHeaderView *)headerView imageViewTap:(PFHerderImageView *)imageView;

@end

@interface PFHeaderView : UIView

@property (nonatomic, strong) NSArray *headers;
@property (nonatomic, weak) id<PFHeaderViewDelegate> delegate;
@end
