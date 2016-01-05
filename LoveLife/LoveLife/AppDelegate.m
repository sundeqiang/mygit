//
//  AppDelegate.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageView.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
//qq
#import "UMSocialQQHandler.h"
//微博
#import "UMSocialWechatHandler.h"
//新浪
#import "UMSocialSinaHandler.h"
//#define isRuned @"1"
@interface AppDelegate ()

@property (nonatomic, strong) MyTabBarViewController* myTabBar;

@property (nonatomic ,strong) GuidePageView *guidePage;

@end
/**
 *  页面的几种架构
    1.分栏式
    2.单页式
    3.滚动式
    4.抽屉式
 */
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //修改状态栏的颜色（第二中方式）可以修改全局（要修改plist）
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.myTabBar = [[MyTabBarViewController alloc]init
                     ];
    
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    MMDrawerController *drawVC = [[MMDrawerController alloc]initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVC];
    self.window.rootViewController = drawVC;
    //设置抽屉页面打开和关闭的模式
    drawVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawVC.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    //设置做页面打开之后的宽度
    drawVC.maximumLeftDrawerWidth = SizeW - 100;
    /*
     MMOpenDrawerGestureModeNone                     = 0,
     MMOpenDrawerGestureModePanningNavigationBar     = 1 << 1,
     MMOpenDrawerGestureModePanningCenterView        = 1 << 2,
     MMOpenDrawerGestureModeBezelPanningCenterView   = 1 << 3,
     MMOpenDrawerGestureModeCustom                   = 1 << 4,
     MMOpenDrawerGestureModeAll                      =   MMOpenDrawerGestureModePanningNavigationBar     |
     MMOpenDrawerGestureModePanningCenterView        |
     MMOpenDrawerGestureModeBezelPanningCenterView   |
     MMOpenDrawerGestureModeCustom,
     */
    //添加引导页
    
    [self createGuidePage];
    //添加友盟分享
    [self addUMShare];
    return YES;
}

#pragma mark --- 添加友盟分享
- (void)addUMShare{
    //注册友盟分享
    [UMSocialData setAppKey:APPKEY];
    //设置QQ的appid appkey和url
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    //设置微信的appid，appsecret和url
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    //打开微博的sso开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //隐藏未安装的客户端 (这一步针对qq和微信)
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}

- (void)createGuidePage{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isRuned"] boolValue]){
        NSArray *imageArray = @[@"welcome6",@"welcome4",@"welcome5"];
        self.guidePage = [[GuidePageView alloc]initWithFrame:self.window.bounds ImageArray:imageArray];
        [self.myTabBar.view addSubview:self.guidePage];
        //第一次运行后进行记录
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRuned"];
        
    }
    [self.guidePage.goInButton addTarget:self action:@selector(goinButtonClinc) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goinButtonClinc{
    [self.guidePage removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
