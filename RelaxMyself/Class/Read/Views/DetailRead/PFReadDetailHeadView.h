//
//  PFReadDetailHeadView.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    mostHot,
    mostNew
}PFReadDetailHeadViewButtonType;

@class PFReadDetailHeadView;

@protocol PFReadDetailHeadViewDelegate <NSObject>
@optional
- (void)readDetailViewHeadView:(PFReadDetailHeadView *)headView buttonClick:(PFReadDetailHeadViewButtonType)type;

@end

@interface PFReadDetailHeadView : UIView
@property (nonatomic, weak) id<PFReadDetailHeadViewDelegate> delegate;

@end
