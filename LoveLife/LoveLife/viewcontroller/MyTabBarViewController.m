//
//  MyTabBarViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "FoodViewController.h"
#import "MyViewController.h"
#import "MusicViewController.h"
//#import "<#header#>"


@interface MyTabBarViewController ()


@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createController];
    [self createTabBarItem];

}

- (void)createController{
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:homeVc];
    homeVc.view.backgroundColor = RGB(arc4random()*255, arc4random()*255, arc4random()*255, 1);
    MyViewController *MyVC = [[MyViewController alloc]init];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:MyVC];
    MyVC.view.backgroundColor = RGB(arc4random()*255, arc4random()*255, arc4random()*255, 1);
    FoodViewController *foodVC = [[FoodViewController alloc]init];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:foodVC];
    foodVC.view.backgroundColor = RGB(arc4random()*255, arc4random()*255, arc4random()*255, 1);
    ReadViewController *ReadVc = [[ReadViewController alloc]init];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:ReadVc];
    ReadVc.view.backgroundColor = RGB(arc4random()*255, arc4random()*255, arc4random()*255, 1);
    MusicViewController *musicVc = [[MusicViewController alloc]init];
    UINavigationController *nvc5 = [[UINavigationController alloc]initWithRootViewController:musicVc];
    musicVc.view.backgroundColor = [UIColor colorWithRed:arc4random()/255.0*255 green:arc4random()*255/255.0 blue:arc4random()*255/255.0 alpha:1];
//    musicVc.view.backgroundColor = RGB(arc4random()*255, arc4random()*255, arc4random()*255, 1);
    self.viewControllers = @[nvc1,nvc4,nvc3,nvc5,nvc2];
}

- (void)createTabBarItem{
    //未选中的图片
    NSArray * unSelectedImageNames=@[@"ic_tab_home_normal@2x",@"ic_tab_category_normal@2x",@"iconfont-iconfontmeishi",@"health",@"ic_tab_profile_normal_female@2x"];
    
    //选中时的图片
    NSArray * SelectedImageNames=@[@"ic_tab_home_selected@2x",@"ic_tab_category_selected@2x",@"iconfont-iconfontmeishi-2",@"health2",@"ic_tab_profile_selected_female@2x"];
    
    //标题
    NSArray * titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];
    
    
    //循环赋值
    for (int i =0; i<unSelectedImageNames.count; i++)
    {
        UIImage * unSelectedImage=[UIImage imageNamed:unSelectedImageNames[i]];
        
        unSelectedImage = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * selectedImage = [UIImage imageNamed:SelectedImageNames[i]];
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取Item并且赋值
        UITabBarItem * item = self.tabBar.items[i];
        
        item = [item initWithTitle:titleArray[i] image:unSelectedImage selectedImage:selectedImage];
    }
    
    //设置选中时的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
        /*
         UIImageRenderingModeAutomatic,          // Use the default rendering mode for the context where the image is used
         
         UIImageRenderingModeAlwaysOriginal,     // Always draw the original image, without treating it as a template
         UIImageRenderingModeAlwaysTemplate,
         */
        
        //获取ite并复制
//        UIBarButtonItem *item = self.tabBar.
        //设置选中时标题的颜色
//        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
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
