//
//  PFReadArticleVc.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/31.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFReadArticleVc.h"
#import "MJExtension.h"
#import "PFReadHttpTool.h"
#import "PFReadArticleDataCancheTool.h"
#import "PFArticleModel.h"
#import "PFReadHeaderAticleRequest.h"
//#import "UMSocial.h"
#import "MBProgressHUD+MJ.h"


@interface PFReadArticleVc ()<UIWebViewDelegate>


@property (nonatomic, copy) NSString * html;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, assign) NSUInteger isFirst;

@end

@implementation PFReadArticleVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    [self requsetData];
    
//    UIBarButtonItem *shareButton = [UIBarButtonItem itemWithImageName:@"share" target:self action:@selector(shareClick)];
//    self.navigationItem.rightBarButtonItem = shareButton;
}
//
//- (void)shareClick
//{
//    NSString *text = @"分享美文，分享知识";
//    NSString *url = self.html;
//    NSString *str = PFFORMAT(@"%@:%@",text,url);
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPP_KEY shareText:str shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToSms,UMShareToEmail] delegate:self];
//
//}

//#pragma mark -- UMSocialUIDelegate
//- (BOOL)isDirectShareInIconActionSheet
//{
//    return YES;
//}
//
//- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    if (response.responseCode == UMSResponseCodeSuccess) {
//        [MBProgressHUD showSuccess:@"分享成功"];
//    }else if (response.responseCode == UMSResponseCodeFaild){
//        [MBProgressHUD showError:@"分享失败"];
//    }
//}
- (void)requsetData
{
    PFArticleModel *model =  [[PFReadArticleDataCancheTool dataWithIdstr:self.url] firstObject];
    if (self.isFirst == 0 && model) {
        self.html = [model.html copy];
        [self.webView loadHTMLString:self.html baseURL:nil];
        ++ self.isFirst;
        return;
    }
    
    PFReadHeaderAticleRequest *request = [[PFReadHeaderAticleRequest alloc] init];
    request.contentid = self.url;
    
    
    [PFReadHttpTool readDetailWithParameter:request success:^(PFArticleModel *result) {
        [PFReadArticleDataCancheTool deleteWithIdstr:self.url];
        [PFReadArticleDataCancheTool saveDataWithModel:result idstr:self.url];
        ++ self.isFirst;
        
        self.html = [result.html copy];
        [self.webView loadHTMLString:self.html baseURL:nil];
    } failure:^(NSError *error) {
        PFLog(@"PFReadHeaderVc");
        [MBProgressHUD showError:@"加载失败，请检查网络设置"];
    }];
    
}

#warning 不知道干嘛用的  js的交互
#pragma mark --UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 缩放内容
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '85%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    // 缩放图片
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=320;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
}


@end
