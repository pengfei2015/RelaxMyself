//
//  PFWalterFlowView.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFWalterFlowView.h"
#import "PFWalterFlowCell.h"

#define PFWALTERVIEW_CLOUM 3
#define PFWALTERVIEW_MARGIN_DEFAULT 5
#define PFWALTERVIEW_CELLHEIGHT_DEFAULT 70


@interface PFWalterFlowView ()

@property (nonatomic, strong) NSMutableArray *cellFrames;
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
@property (nonatomic, strong) NSMutableSet *reusableCells;
@end
@implementation PFWalterFlowView

- (NSMutableArray *)cellFrames
{
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (!_displayingCells) {
        _displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (!_reusableCells) {
        _reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}


#pragma mark -- 公共方法
- (void)reloadData
{
    NSUInteger cells = [self numberOfCell];
    NSUInteger colums = [self numberOfCloum];
    
    
    // 设置间距
    CGFloat topMargin = [self marginForType:PFWalterFlowMarginTop];
    CGFloat bottomMargin = [self marginForType:PFWalterFlowMarginBottom];
    CGFloat leftMargin = [self marginForType:PFWalterFlowMarginLeft];
    CGFloat rightMargin = [self marginForType:PFWalterFlowMarginRight];
    CGFloat rowMargin = [self marginForType:PFWalterFlowMarginRow];
    CGFloat columMargin = [self marginForType:PFWalterFlowMarginColum];
    
    // 计算宽度
    CGFloat cellW = (self.width - leftMargin - rightMargin - columMargin * (colums - 1)) / colums;
    CGFloat maxYOfColums[colums];
    for (NSUInteger i = 0; i < colums; ++i) {
        maxYOfColums[i] = 0;
    }
    
    for (int i = 0; i < cells; ++i) {
        NSUInteger maxColum = 0; // 保存最短cell的那列
        CGFloat maxYOfCloum = maxYOfColums[maxColum];// 保存最短cell的高度 也是每列的最大高度
        
        for (int j = 0; j < colums; ++j) {
            // 找出最短的高度的那列 和最短的高度
            if (maxYOfCloum > maxYOfColums[j]){
                maxColum = j;
                maxYOfCloum = maxYOfColums[j];
            }
        }
        
        CGFloat cellH =[self cellHeightAtIndex:i];
        
        CGFloat cellX = leftMargin + maxColum * (cellW + columMargin);
        
        CGFloat cellY = 0;
        if (maxYOfCloum == 0.0) {
            cellY = topMargin;
        }else{
            cellY = maxYOfCloum + rowMargin;
        }
        
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        // 赋值
        maxYOfColums[maxColum] = CGRectGetMaxY(cellFrame);
        
    }
    
    CGFloat contentH = maxYOfColums[0];
    for (int i = 0; i < colums; ++i) {
        if (maxYOfColums[i] > contentH) {
            contentH = maxYOfColums[i];
        }
    }
    
    contentH += bottomMargin;
    self.contentSize = CGSizeMake(0, contentH);

}



- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    
    __block PFWalterFlowCell *reusalbeCell = nil;
    [self.reusableCells enumerateObjectsUsingBlock:^(PFWalterFlowCell *_Nonnull cell, BOOL * _Nonnull stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusalbeCell = cell;
            *stop = YES;
        }
    }];

    if (reusalbeCell) {
        [self.reusableCells removeObject:reusalbeCell];
    }
    return reusalbeCell;
}
#pragma mark -- 私有方法

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger cells = self.cellFrames.count;
    
    for (int i = 0; i < cells; ++i) {
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        PFWalterFlowCell *cell = self.displayingCells[@(i)];
        if ([self isInScreen:cellFrame]) {
            // 如果frame的位置在屏幕上  但是没有取到cell  就创建cell  如果取到cell的话就说明cell的属性已经设置好了
            if (!cell) {
                cell = [self.dataSourse walterFlowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                self.displayingCells[@(i)] = cell;
            }
        }else{
            if (cell) {
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                [self.reusableCells addObject:cell];
            }
        }
    }

}

// 判断是否在屏幕上
- (BOOL)isInScreen:(CGRect)frame
{
    CGFloat maxY = CGRectGetMaxY(frame);
    CGFloat minY = CGRectGetMaxY(frame);
    
    return (maxY > self.contentOffset.y && minY < self.contentOffset.y + self.height);
}

// 获得单元格数
- (NSUInteger)numberOfCell
{
    if ([self.dataSourse respondsToSelector:@selector(numberOfCellInWalterFlowView:)]) {
        return [self.dataSourse numberOfCellInWalterFlowView:self];
    }
    return 0;
}

// 获得行数
- (NSUInteger)numberOfCloum
{
    if ([self.dataSourse respondsToSelector:@selector(numberOfCloumInWalterFlowView:)]) {
        return [self.dataSourse numberOfCloumInWalterFlowView:self];
    }
    return PFWALTERVIEW_CLOUM;
}

// 获得间距
- (CGFloat)marginForType:(PFWalterFlowViewMarginType)type
{
    if ([self.walterDelegate respondsToSelector:@selector(walterFlowView:maginForType:)]) {
        return [self.walterDelegate walterFlowView:self maginForType:type];
    }
    return PFWALTERVIEW_MARGIN_DEFAULT;
}

// 获得行高
- (CGFloat)cellHeightAtIndex:(NSUInteger)index
{
    if ([self.walterDelegate respondsToSelector:@selector(walterFlowView:heightAtIndex:)]) {
        return [self.walterDelegate walterFlowView:self heightAtIndex:index];
    }
    return PFWALTERVIEW_MARGIN_DEFAULT;
}

// 当被添加进父视图的时候刷新数据
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.walterDelegate respondsToSelector:@selector(walterFlowView:didSelectCellAtIndex:)]) return;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, PFWalterFlowCell  *_Nonnull cell, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.walterDelegate walterFlowView:self didSelectCellAtIndex:[selectIndex unsignedIntegerValue]];
    }
}

@end
