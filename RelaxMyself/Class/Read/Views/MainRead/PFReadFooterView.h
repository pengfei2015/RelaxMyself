//
//  PFFooterView.h
//  简
//
//  Created by 温鹏飞 on 15/12/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFReadButton.h"

@class PFReadFooterView;
@protocol PFReadFooterViewDelegate <NSObject>

@optional
- (void)footerView:(PFReadFooterView *)footerView buttonClick:(PFReadButton *)button;

@end
@interface PFReadFooterView : UIView

@property (nonatomic, strong) NSArray *footers;
@property (nonatomic, weak) id<PFReadFooterViewDelegate> delegate;

@end
