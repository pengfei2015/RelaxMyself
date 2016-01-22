//
//  PFWaterViewLayout.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/22.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFWaterFlowLayout;

@protocol PFWaterFlowLayoutDelegate <NSObject>

@optional
- (CGFloat)waterFlowLayout:(PFWaterFlowLayout *)layout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end


@interface PFWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;
/**
 *  列边距
 */
@property (nonatomic, assign) CGFloat columsMargin;

/**
 *  行边距
 */
@property (nonatomic, assign) CGFloat rowMargin;

/**
 *  列数
 */
@property (nonatomic, assign) NSUInteger columsCount;

@property (nonatomic, weak) id<PFWaterFlowLayoutDelegate> delegate;

@end
