
//
//  UILableViewController.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "UILableViewController.h"

@interface UILableViewController ()
{
    UILabel *_lable;
}
//@property (nonatomic, strong) UILabel * lable;

@end

@implementation UILableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createUI];
    [self createUI2];
}


- (void)createUI
{
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,self.view.frame.size.height/4)];
    _lable.backgroundColor = [UIColor redColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.textColor = [UIColor greenColor];
    _lable.text = @"全屏宽";
    _lable.adjustsFontSizeToFitWidth = YES;
//    _lable.center = self.view.center;
//    _lable.center = CGPointMake(50, 60);
    [self.view addSubview:_lable];
}


- (void)createUI2{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建uilabel
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
    
    //设置背景色
    label1.backgroundColor = [UIColor grayColor];
    
    //设置tag
    label1.tag = 91;
    
    //设置标签文本
    label1.text = @"Hello world!Hello world!Hello world!Hello world!Hello world!Hello world!Hello world!Hello world!Hello world!";
    
    
    //设置标签文本字体和字体大小
    label1.font = [UIFont fontWithName:@"Heiti SC" size:30];
    NSLog(@"%@",[UIFont familyNames]);
    //设置文本对其方式
    label1.textAlignment = UITextAlignmentCenter;
    //文本对齐方式有以下三种
    //typedef enum {
    //    UITextAlignmentLeft = 0,左对齐
    //    UITextAlignmentCenter,居中对齐
    //    UITextAlignmentRight, 右对齐
    //} UITextAlignment;
    
    //文本颜色
    label1.textColor = [UIColor redColor];
    //超出label边界文字的截取方式
    label1.lineBreakMode = UILineBreakModeTailTruncation;
    //截取方式有以下6种
    //typedef enum {
    //    UILineBreakModeWordWrap = 0,    以空格为边界，保留整个单词
    //    UILineBreakModeCharacterWrap,   保留整个字符
    //    UILineBreakModeClip,            到边界为止
    //    UILineBreakModeHeadTruncation,  省略开始，以……代替
    //    UILineBreakModeTailTruncation,  省略结尾，以……代替
    //    UILineBreakModeMiddleTruncation,省略中间，以……代替，多行时作用于最后一行
    //} UILineBreakMode;
    
    //文本文字自适应大小
//    label1.adjustsFontSizeToFitWidth = YES;
    //当adjustsFontSizeToFitWidth=YES时候，如果文本font要缩小时
    //baselineAdjustment这个值控制文本的基线位置，只有文本行数为1是有效
    label1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    //有三种方式
    //typedef enum {
    //    UIBaselineAdjustmentAlignBaselines = 0, 默认值文本最上端于label中线对齐
    //    UIBaselineAdjustmentAlignCenters,//文本中线于label中线对齐
    //    UIBaselineAdjustmentNone,//文本最低端与label中线对齐
    //} UIBaselineAdjustment;
    
    //文本最多行数，为0时没有最大行数限制
    label1.numberOfLines = 2;
    //最小字体，行数为1时有效，默认为0.0
    label1.minimumFontSize = 10.0;
    //文本高亮
    label1.highlighted = YES;
    //文本是否可变
    label1.enabled = YES;
    //去掉label背景色
    //label1.backgroundColor = [UIColor clearColor];
    
    //文本阴影颜色
    label1.shadowColor = [UIColor yellowColor];
    //阴影大小
    label1.shadowOffset = CGSizeMake(0.5, 0.5);
    
    //是否能与用户交互
    label1.userInteractionEnabled = YES;
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    but = (UIView*)label1;
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"╮(╯▽╰)╭" forState:UIControlStateNormal];
    but.frame = CGRectMake(100, 100, 100, 60);
    [but addTarget:self action:@selector(lkl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    [self.view addSubview:label1];
    }

- (void)lkl
{
     self.modalPresentationStyle = UIModalPresentationPopover;
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
