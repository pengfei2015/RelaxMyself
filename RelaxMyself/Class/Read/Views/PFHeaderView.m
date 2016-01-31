//
//  PFHeaderView.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFHeaderView.h"
#import "UIImageView+WebCache.h"
#import "PFReadHeaderModel.h"

@interface PFHeaderView ()<UIScrollViewDelegate>


@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


@end
@implementation PFHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        
        // 添加分页视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor purpleColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 添加定时器
        
        [self setupTimer];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(self.width * 2 / 3, self.height - 20, self.width / 3, 20);
}

#pragma mark -- 设置数据
- (void)setHeaders:(NSArray *)headers
{
    _headers = headers;
    self.scrollView.contentSize = CGSizeMake(self.width * self.headers.count, self.height);
    
    self.pageControl.numberOfPages = _headers.count;
    
    for (int i = 0; i < _headers.count; ++i) {
        PFReadHeaderModel *header = _headers[i];
        // 如果子空间多  也就是已经创建过了 旧不再创建
        if (self.scrollView.subviews.count <= _headers.count) {
            PFHerderImageView *imageView = [[PFHerderImageView alloc] init];
            imageView.url = header.url;
            [imageView setImageWithURL:[NSURL URLWithString:header.img] placeholderImage:[UIImage imageNamed:@"Icon"]];
            CGFloat imageViewW = self.width;
            CGFloat imageViewH = self.height;
            CGFloat imageViewX = self.width * i;
            CGFloat imageViewY = 0;
            imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            imageView.userInteractionEnabled = YES;
            
            // 添加手势
            UITapGestureRecognizer *recognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPgoto:)];
            [imageView addGestureRecognizer:recognize];
            
            [self.scrollView addSubview:imageView];
        }
    }
}

#pragma mark -- 图片点击
- (void)tapPgoto:(UITapGestureRecognizer *)recognize
{
    if ([self.delegate respondsToSelector:@selector(headerView:imageViewTap:)]) {
        
        PFHerderImageView *imageView = (PFHerderImageView *)recognize.view;
        [self.delegate headerView:self imageViewTap:imageView];
    }
}


#pragma mark -- 定时器

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)destroyTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    static int i = 1;
    self.pageControl.currentPage += i;
    
    if (0 == self.pageControl.currentPage || 2 == self.pageControl.currentPage) {
        i = -i;
    }
    //self.scrollView.contentOffset.x = self.pageControl.currentPage * self.scrollView.width;
    [self.scrollView setContentOffset:CGPointMake(self.pageControl.currentPage * self.scrollView.width, 0) animated:YES];
}

#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int) (scrollView.contentOffset.x / scrollView.width + 0.5);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self destroyTimer];
}
@end
