//
//  PFWaterViewLayout.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/22.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFWaterFlowLayout.h"

@interface PFWaterFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *maxYDict;

@property (nonatomic, strong) NSMutableArray *attrsArr;

@end
@implementation PFWaterFlowLayout

- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        _maxYDict = [NSMutableDictionary dictionary];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArr
{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

- (instancetype)init
{
    // 初始化 设置默认属性
    if (self = [super init]) {
        self.rowMargin = 5;
        self.columsMargin = 5;
        self.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
        self.columsCount = 3;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  每次布局之前的准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    for (int i = 0; i < self.columsCount; ++i) {
        NSString *colum = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[colum] = @(self.sectionInset.top);
    }
    
    [self.attrsArr removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; ++i) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArr addObject:attrs];
    }
}


/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColum = @"0";
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull colum, NSNumber * _Nonnull maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColum] floatValue]) {
            maxColum = [colum copy];
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColum] floatValue] + self.sectionInset.bottom);
}

/**
 *  返回indexPath这个位置的item的属性
 */

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSString *minColum = @"0";
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull colum, NSNumber * _Nonnull maxY, BOOL * _Nonnull stop) {
        if ([maxY floatValue] < [self.maxYDict[minColum] floatValue]) {
            minColum = [colum copy];
        }
    }];
    
    // 计算尺寸
    
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columsCount - 1) * self.columsMargin) / self.columsCount;
    
    CGFloat height = [self.delegate waterFlowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    // 计算位置
    
    CGFloat x = self.sectionInset.left + (width + self.columsMargin) * [minColum intValue];
    CGFloat y = [self.maxYDict[minColum] floatValue] + self.rowMargin;
    
    self.maxYDict[minColum] = @(y + height);
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}

/**
 *  返回rect范围内的布局属性
 */

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArr;
}


@end
