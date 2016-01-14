//
//  MakePrintView.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "MakePrintView.h"
#import "YTView.h"

@interface MakePrintView ()

@end

@implementation MakePrintView

- (void)viewDidLoad {
    [super viewDidLoad];
    YTView *bgView = [[YTView alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
