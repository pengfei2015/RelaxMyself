//
//  PFWalterFlowView.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PFWalterFlowViewMarginType)
{
    PFWalterFlowMarginLeft,
    PFWalterFlowMarginRight,
    PFWalterFlowMarginTop,
    PFWalterFlowMarginBottom,
    PFWalterFlowMarginRow,
    PFWalterFlowMarginColum
};

@class PFWalterFlowView,PFWalterFlowCell;

@protocol PFWalterFlowViewDataSourse <NSObject>

@required
- (NSUInteger)numberOfCellInWalterFlowView:(PFWalterFlowView *)walterFlowView;

- (PFWalterFlowCell *)walterFlowView:(PFWalterFlowView *)walterFlowView cellAtIndex:(NSUInteger)index;

@optional
- (NSUInteger)numberOfCloumInWalterFlowView:(PFWalterFlowView *)walterFlowView;
@end



@protocol PFWalterFlowViewDelegate <NSObject>

@optional

- (void)walterFlowView:(PFWalterFlowView *)walterFlowView didSelectCellAtIndex:(NSUInteger)index;
- (CGFloat)walterFlowView:(PFWalterFlowView *)walterFlowView maginForType:(PFWalterFlowViewMarginType)type;
- (CGFloat)walterFlowView:(PFWalterFlowView *)walterFlowView heightAtIndex:(NSUInteger)index;


@end


@interface PFWalterFlowView : UIScrollView

@property (nonatomic, weak) id<PFWalterFlowViewDataSourse> dataSourse;

@property (nonatomic, weak) id<PFWalterFlowViewDelegate> walterDelegate;

- (void)reloadData;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
