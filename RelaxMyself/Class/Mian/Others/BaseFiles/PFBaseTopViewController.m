//
//  PFBaseTopViewController.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/31.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFBaseTopViewController.h"

@interface PFBaseTopViewController ()

@property (nonatomic, strong) UIButton *topButton;

@end

@implementation PFBaseTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

#pragma mark --创建向上按钮
- (void)setupTopButton
{
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame = CGRectMake(self.view.width - 20 - 30, self.view.height - 20 - 30, 30, 30);
    [topButton setBackgroundImage:[UIImage imageNamed:@"topArrow"] forState:UIControlStateNormal];
    topButton.hidden = YES;
    [topButton addTarget:self action:@selector(walkToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];

    self.topButton = topButton;
    
}


- (void)walkToTop
{
    
}


#pragma mark -- scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.topButton.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.topButton.hidden = NO;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.topButton.hidden = NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.topButton.hidden = YES;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.topButton.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupTopButton];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //self.topButton.hidden = YES;
}
@end
