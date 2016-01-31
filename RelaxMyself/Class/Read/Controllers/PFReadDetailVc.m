//
//  PFReadDetailVc.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadDetailVc.h"
#import "PFReadDetailHeadView.h"
#import "PFReadDetailRequest.h"
#import "PFReadHttpTool.h"
#import "PFReadDetailCell.h"
#import "PFReadFooterModel.h"
#import "PFReadDeitailDataCacheTool.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "PFReadArticleVc.h"
#import "PFReadDetailListModel.h"


typedef NS_ENUM(NSUInteger,PFRequestType) {
    PFRequestNew,
    PFRequestMore
};


@interface PFReadDetailVc ()<UITableViewDataSource,UITableViewDelegate,PFReadDetailHeadViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) PFReadDetailHeadView *headView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *articles;
// 请求参数
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) PFReadDetailRequest *request;
// 判断是哪个类型
@property (nonatomic, copy) NSString *displayingType;

// 判断是不是最后一个的URL
@property (nonatomic, copy) NSString *url;


@end


@implementation PFReadDetailVc

- (PFReadDetailRequest *)request
{
    if (!_request) {
        _request = [[PFReadDetailRequest alloc] init];
    }
    return _request;
}

- (NSMutableArray *)articles{
    if (!_articles) {
        _articles = [NSMutableArray array];
    }
    return _articles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.currentPage = 0;
    // 添加头部按钮视图
    [self setupHeadView];
    
    // 添加tableview
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 130;
    tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), self.view.width, self.view.height - CGRectGetMaxY(self.headView.frame));
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView addHeaderWithTarget:self action:@selector(requestNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(requestMoreData)];
    
    //[self.tableView headerBeginRefreshing];
    [self readDetailViewHeadView:self.headView buttonClick:mostNew];
}

#pragma mark -- 加载数据

- (void)requestNewData
{
    [self loadDataForType:PFRequestNew];
    
}

- (void)requestMoreData
{
    [self loadDataForType:PFRequestMore];
}

- (void)loadDataForType:(PFRequestType)type
{
    // 根据item头像的地址确定唯一标识  用来存储数据和取数据
   // NSString *idstr = self.footer.title;
    NSString *idstr = PFFORMAT(@"%@%@",self.footer.title,self.request.sort);
    // 取出的数据
    NSArray *arr = [PFReadDeitailDataCacheTool dataWithIdstr:idstr];
    // 如果当前显示的页面和点击的页面不是同一页面 并且有缓存数据的时候 从缓存中取出数据
    if (arr.count > 0 && ![self.request.sort isEqualToString:self.displayingType]) {
        // 清空上一页面的数据
        [self.articles removeAllObjects];
        
        [self.articles addObjectsFromArray:arr];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
        [self.tableView setContentOffset:CGPointZero animated:NO];
        // 赋值
        //++ self.isFirst;
        self.displayingType = self.request.sort;
        return;
    }
    
    self.request.limit = 10;
    //self.request.sort = @"addtime";
    self.request.typeid = self.footer.type;
    
    if (PFRequestNew == type) {
        self.currentPage = 0;
    }else{
        // 根据现有的个数 判断应该从哪里开始加载
        self.currentPage = self.articles.count;
    }
    self.request.start = self.currentPage;
    
    [PFReadHttpTool readDetailListWithUrl:self.url parameter:self.request success:^(PFReadDetailModel *result) {
        NSArray *articles = result.list;

        if (PFRequestNew == type) {
            if (articles.count) {
                [self.articles removeAllObjects];
            }
            [self.tableView headerEndRefreshing];
        }else{
            [self.tableView footerEndRefreshing];
        }
        [self.articles addObjectsFromArray:articles];
        [self.tableView reloadData];

        [PFReadDeitailDataCacheTool saveDataWithArr:self.articles idstr:idstr];
        self.displayingType = self.request.sort;

    } failure:^(NSError *error) {
        PFLog(@"PFReadDetailVc");
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [MBProgressHUD showError:@"加载失败，请检查网络设置"];
    }];

    
}

/**
 *  添加头部按钮视图
 */
- (void)setupHeadView
{
    PFReadDetailHeadView *headView = [[PFReadDetailHeadView alloc] init];
    headView.delegate = self;
    headView.backgroundColor = [UIColor grayColor];
    headView.frame = CGRectMake(0, 64, self.view.width, 44);
    [self.view addSubview:headView];
    self.headView = headView;
}
- (void)setFooter:(PFReadFooterModel *)footer
{
    _footer = footer;
    self.title = footer.name;
    
    if (PFREAD_FOOTER_TYPE == footer.type) {
        self.url = @"http://api2.pianke.me/read/latest";
    }else{
        self.url = @"http://api2.pianke.me/read/columns_detail";
    }
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFReadDetailCell *cell = [PFReadDetailCell cellWithTableView:tableView];
    cell.article = self.articles[indexPath.row];
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFReadDetailListModel *model = self.articles[indexPath.row];
    PFReadArticleVc *articleVc = [[PFReadArticleVc alloc] init];
    NSString *url = [model.id copy];
    if (url.length == 0) {
        url = [model.contentid copy];
    }
    articleVc.url = url;
    [self.navigationController pushViewController:articleVc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- PFReadDetailHeadViewDelegate
- (void)readDetailViewHeadView:(PFReadDetailHeadView *)headView buttonClick:(PFReadDetailHeadViewButtonType)type
{
    switch (type) {
        case mostNew:
        {
            self.request.sort = @"addtime";
        }
            break;
        case mostHot:
        {
            self.request.sort = @"hot";
        }
            break;
        default:
            break;
    }
    [self requestNewData];
}

- (void)walkToTop
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}
@end
