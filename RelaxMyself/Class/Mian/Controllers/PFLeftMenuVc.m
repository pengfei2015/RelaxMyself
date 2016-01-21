//
//  PFLeftMenuVc.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFLeftMenuVc.h"
#import "PFLeftCell.h"
#import "PFMainViewController.h"
#import "AppDelegate.h"
#import "PFMainNavViewController.h"

@interface PFLeftMenuVc ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
}
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *controllerNames;
@end

@implementation PFLeftMenuVc

- (NSArray *)controllerNames
{
    if (!_controllerNames) {
        _controllerNames = @[@"PFPictureVc",@"PFReadingVc",@"PFMusicVc"];
    }
    return _controllerNames;
}
- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"图片",@"音乐",@"阅读"];
    }
    return _titles;
}

- (NSArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = @[@"mine2",@"echo2",@"feed2"];
    }
    return _imageNames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"start_bg"];
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.size = CGSizeMake(self.view.width, 200);
    tableView.center = self.view.center;
    [self.view addSubview:tableView];
    _tableView = tableView;

}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFLeftCell *cell = [PFLeftCell cellWithTableView:tableView];
    cell.titleLab.text = self.titles[indexPath.row];
    NSString *name = self.imageNames[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:name];
    return cell;
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableView.height / self.titles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *name = self.controllerNames[indexPath.row];
    Class className = NSClassFromString(name);
    
    PFMainViewController *ddvc = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainVc;
    UIViewController *vc = [[className alloc] init];
    PFMainNavViewController *nav = [[PFMainNavViewController alloc] initWithRootViewController:vc];
    [ddvc setRootController:nav animated:YES];
    
    vc.title = self.titles[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
