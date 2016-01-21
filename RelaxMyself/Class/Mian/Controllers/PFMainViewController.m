//
//  PFMainViewController.m
//  RelaxMyslef
//
//  Created by 温鹏飞 on 16/1/21.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMainViewController.h"
#import "PFPictureVc.h"
#import "PFMainNavViewController.h"
#import "PFLeftMenuVc.h"


@interface PFMainViewController ()

@end

@implementation PFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFPictureVc *picture = [[PFPictureVc alloc] init];
    picture.title = @"图片";
    PFMainNavViewController *nav =  [[PFMainNavViewController alloc] initWithRootViewController:picture];
    self.rootViewController = nav;
    
    
    PFLeftMenuVc *leftMenu = [[PFLeftMenuVc alloc] init];
    self.leftViewController = leftMenu;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
