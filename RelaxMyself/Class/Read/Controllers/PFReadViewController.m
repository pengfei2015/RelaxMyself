//
//  PFReadViewController.m
//  简
//
//  Created by 温鹏飞 on 15/12/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadViewController.h"
#import "PFReadFooterView.h"
#import "PFHeaderView.h"
#import "PFReadDetailVc.h"
#import "PFReadDataCacheTool.h"
#import "PFReadHttpTool.h"
#import "PFReadArticleVc.h"
#import "MBProgressHUD+MJ.h"


@interface PFReadViewController ()<PFHeaderViewDelegate,PFReadFooterViewDelegate>

@property (nonatomic, weak) PFHeaderView *headerView;
@property (nonatomic, weak) PFReadFooterView *footerView;
@property (nonatomic, assign) NSUInteger isFirst;

@end

@implementation PFReadViewController

static NSString *const _readModel = @"readModel";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // nav 的第一个子视图是scrollview的时候  系统会自动加上64的偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 下载数据
   
    
    // 添加头部view
    PFHeaderView *headerView = [[PFHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 64, self.view.width, 120);
    headerView.delegate = self;
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    // 添加底部view
    [self setupFooterView];
    
    [self downLoadDatas];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(downLoadDatas)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)downLoadDatas
{
    PFReadDataModel *model = [[PFReadDataCacheTool dataWithIdstr:_readModel] firstObject];
    if (self.isFirst == 0 && model) {
        self.footerView.footers = model.list;
        self.headerView.headers = model.carousel;
        ++_isFirst;
        return;
    }
    [PFReadHttpTool readDetailWithParameterSuccess:^(PFReadDataModel *result) {
        
        [PFReadDataCacheTool deleteWithIdstr:_readModel];
        ++ _isFirst;
        [PFReadDataCacheTool saveDataWithModel:result idstr:_readModel];
        self.footerView.footers = result.list;
        self.headerView.headers = result.carousel;
    } failure:^(NSError *error) {
        PFLog(@"PFReadViewController");
        [MBProgressHUD showError:@"加载失败，请检查网络设置"];
    }];

}

- (void)setupFooterView
{
    PFReadFooterView *footerView = [[PFReadFooterView alloc] init];
    CGFloat footerX = 0;
    footerView.delegate = self;
    CGFloat footerY = CGRectGetMaxY(self.headerView.frame);
    CGFloat footerW = self.view.width;
    CGFloat footerH = self.view.height - footerY;
    footerView.frame = CGRectMake(footerX, footerY, footerW, footerH);
    [self.view addSubview:footerView];
    self.footerView = footerView;
}

#pragma mark -- PFHeaderViewDelegate
- (void)headerView:(PFHeaderView *)headerView imageViewTap:(PFHerderImageView *)imageView
{

    PFReadArticleVc *articleVc = [[PFReadArticleVc alloc] init];
    articleVc.url = imageView.url;
    [self.navigationController pushViewController:articleVc animated:YES];
}

#pragma mark -- PFReadFooterViewDelegate
- (void)footerView:(PFReadFooterView *)footerView buttonClick:(PFReadButton *)button
{
    PFReadDetailVc *vc = [[PFReadDetailVc alloc] init];
    vc.footer = button.footer;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
