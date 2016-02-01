//
//  PFMusicVc.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMusicVc.h"
#import "MJRefresh.h"
#import "PFHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "PFMusicModel.h"
#import "MJExtension.h"
#import "PFMusicDataCacheTool.h"
#import "PFMusicCell.h"
#import "PFMusicPlayingVc.h"


typedef NS_ENUM(NSUInteger,PFRequestType) {
    PFRequestNew,
    PFRequestMore
};

@interface PFMusicVc ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isFirst;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *musics;
@end

@implementation PFMusicVc

static NSString *const _idstr = @"music";
static NSUInteger _page = 1;


- (NSMutableArray *)musics
{
    if (!_musics) {
        _musics = [NSMutableArray array];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    self.tableView.rowHeight = 120;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark -- 加载数据

- (void)loadNewData
{
    [self loadDataForType:PFRequestNew];
    
}

- (void)loadMoreData
{
    [self loadDataForType:PFRequestMore];
}

- (void)loadDataForType:(PFRequestType)type
{

    NSArray *arr = [PFMusicDataCacheTool dataWithIdstr:_idstr];

    if (_isFirst == 0 && arr.count > 0) {
        // 清空上一页面的数据
        [self.musics removeAllObjects];
        
        [self.musics addObjectsFromArray:arr];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
        // 赋值
        _isFirst = 1;
        return;
    }
    
    if (PFRequestNew == type) {
        _page = 1;
    }else{
        _page = self.musics.count / 10 + 1;
    }
    //194
    NSString *url = PFFORMAT(@"http://echosystem.kibey.com/channel/info?id=194&page=%lu",(unsigned long)_page);
    [PFHttpTool GET:url parameters:nil progress:nil success:^(id response) {
        NSDictionary *result = response[@"result"];
        NSDictionary *data = result[@"data"];
        NSArray *sounds = data[@"sounds"];
        NSArray *musics = [PFMusicModel objectArrayWithKeyValuesArray:sounds];
        
        if (PFRequestNew == type) {
            if (musics.count) {
                [self.musics removeAllObjects];
            }
            [self.tableView headerEndRefreshing];
        }else{
            [self.tableView footerEndRefreshing];
        }

        [self.musics addObjectsFromArray:musics];
        [self.tableView reloadData];

        [PFMusicDataCacheTool saveDataWithArr:self.musics idstr:_idstr];
        _isFirst = 1;
        
    } failure:^(NSError *error) {
        PFLog(@"PFMusicVc");
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [MBProgressHUD showError:@"加载失败，请检查网络设置"];
    }];
    
}

#pragma mark -- UITableViewDataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFMusicCell *cell = [PFMusicCell cellWithTableView:tableView];
    cell.music = self.musics[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFMusicPlayingVc *playingVc = [[PFMusicPlayingVc alloc] init];
    playingVc.musics = self.musics;
    playingVc.musicIndex = indexPath.row;
    [self.navigationController pushViewController:playingVc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)walkToTop
{
    [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];
}

@end
