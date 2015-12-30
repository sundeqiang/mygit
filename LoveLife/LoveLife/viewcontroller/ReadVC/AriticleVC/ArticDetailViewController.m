//
//  ArticDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "ArticDetailViewController.h"

@interface ArticDetailViewController ()

@end

@implementation ArticDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNVC];
    [self createUI];
}
//创建UI
- (void)createUI{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH)];
    //loadHTMLString家在类似标签式的字符串
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.dataID]]]];
    //使webview适应屏幕大小
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    //webview于javaSript的交互
}

- (void)setNVC{
    self.titleLable.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    [self setLeftButtonclick:@selector(leftButtonclick)];
    [self.rightButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    [self setrightButtonclick:@selector(rightButtonclick)];
}

#pragma  mark---- NCV响应事件

- (void)leftButtonclick{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
- (void)rightButtonclick{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataID]]];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.dataID] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToTwitter,UMShareToWechatSession,UMShareToWechatTimeline] delegate:nil];
    
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
