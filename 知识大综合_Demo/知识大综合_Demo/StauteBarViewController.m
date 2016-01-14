//
//  StauteBarViewController.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "StauteBarViewController.h"

@interface StauteBarViewController ()

@property (nonatomic) BOOL statusBarIsHidden;

@end

@implementation StauteBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self createUI];
//    self.statusBarIsHidden = NO;
}



- (void)createUI
{
//    UIImageView *imggeView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    imggeView.image = [[UIImage imageNamed:@"2"];
//                       [self.view addSubview:imggeView];
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarIsHidden;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self performSelector:@selector(setStatusBarHidden:) withObject:@(YES) afterDelay:3.];
    [self performSelector:@selector(setStatusBarHidden:) withObject:@(NO) afterDelay:6.];
}

//- (void)setStatusBarHidden:(id)sen
//{
//    NSLog(@"sfafa");
//}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation) preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
