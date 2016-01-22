//
//  PFPictureVc.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFPictureVc.h"
#import "DOPNavbarMenu.h"
#import "MJRefresh.h"
#import "PFHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "PFPictureModel.h"
#import "MJExtension.h"
#import "PFWaterFlowLayout.h"
#import "PFPictureCell.h"


typedef NS_ENUM(NSUInteger,PFRequestType) {
    PFRequestNew,
    PFRequestMore
};
#define PFNUMBER_PERROW 4
@interface PFPictureVc ()<DOPNavbarMenuDelegate,PFWaterFlowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

// 导航栏菜单按钮
@property (nonatomic, assign) BOOL menuIsOPen;
@property (nonatomic, strong) DOPNavbarMenu *menu;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) NSArray *itemImages;
@property (nonatomic, strong) NSMutableArray *images;
// 瀑布流界面
@property (nonatomic, weak) UICollectionView *collectionView;

// 网络请求参数
@property (nonatomic, copy) NSString *tag1;
@property (nonatomic, copy) NSString *tag2;
@property (nonatomic, assign) NSUInteger pn;

@end

@implementation PFPictureVc

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSArray *)itemTitles
{
    if (!_itemTitles) {
        _itemTitles = @[@"美女",@"明星",@"汽车",@"宠物",@"动漫",@"设计",@"家具",@"婚嫁",@"摄影",@"美食"];
    }
    return _itemTitles;
}

- (NSArray *)itemImages
{
    if (!_itemImages) {
        _itemImages = @[@"meinvchannel",@"mingxing",@"qiche",@"chongwu",@"dongman",@"sheji",@"jiaju",@"hunjia",@"sheying",@"meishi"];
    }
    return _itemImages;
}

- (DOPNavbarMenu *)menu
{
    if (!_menu) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.itemTitles.count];
        for (int i = 0; i < self.itemTitles.count; ++i) {
            NSString *title = self.itemTitles[i];
            NSString *imageName = self.itemImages[i];
            
            UIImage *image = [UIImage imageNamed:imageName];
            DOPNavbarMenuItem *item = [DOPNavbarMenuItem ItemWithTitle:title icon:image];
            [arr addObject:item];
        }

        _menu = [[DOPNavbarMenu alloc] initWithItems:arr width:self.view.width maximumNumberInRow:PFNUMBER_PERROW];
        _menu.backgroundColor = PFRGBA(0, 0, 0, 0.8);
        _menu.separatarColor = [UIColor clearColor];
        _menu.delegate = self;
    }
    return _menu;
}


static NSString *const ID = @"PFPictureCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"categories" target:self action:@selector(openMenu:)];
    
    self.tag1 = @"美女";
    self.tag2 = @"小清新";
    self.pn = 0;
    
    
    PFWaterFlowLayout *layout = [[PFWaterFlowLayout alloc] init];
    layout.columsCount = 2;
    layout.delegate = self;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"PFPictureCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [collectionView addHeaderWithTarget:self action:@selector(loadNewData)];
    [collectionView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    [self.collectionView headerBeginRefreshing];
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
    NSMutableDictionary *request = [NSMutableDictionary dictionary];
    request[@"rn"] = @30;
    if (PFRequestNew == type) {
        self.pn = 0;
    }else{
        self.pn += 30;
    }
    request[@"pn"] = PFFORMAT(@"%lu",self.pn);
    
    NSString *url = PFFORMAT(@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",self.tag1,self.tag2);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [PFHttpTool GET:url parameters:request progress:nil success:^(id response) {
        //[MBProgressHUD hideHUD];
        
        NSArray *picturs = [PFPictureModel objectArrayWithKeyValuesArray:response[@"imgs"]];
        
        if (PFRequestNew == type) {
            if (picturs.count) {
                [self.images removeAllObjects];
            }
            [self.collectionView headerEndRefreshing];
        }else{
            [self.collectionView footerEndRefreshing];
        }
        
        [self.images addObjectsFromArray:picturs];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        PFLog(@"PFPictureVc");
        [MBProgressHUD showError:@"加载失败，请检查网络设置"];
    }];
    
}
- (void)openMenu:(UIButton *)button
{
    if (self.menu.isOpen) {
        [self.menu dismissWithAnimation:YES];
    }else{
        [self.menu showInNavigationController:self.navigationController];
    }
    
}

#pragma mark -- PFWaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(PFWaterFlowLayout *)layout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    PFPictureModel *model = self.images[indexPath.row];
    return  model.small_height / model.small_width * width;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID     forIndexPath:indexPath];
    cell.picture = self.images[indexPath.item];
    return cell;
}

#pragma mark --
@end
