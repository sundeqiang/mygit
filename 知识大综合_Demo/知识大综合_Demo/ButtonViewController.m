//
//  ButtonViewController.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()
{
    UIButton *_button;
}
@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)createButton
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor greenColor];
    _button.frame = CGRectMake( 0, 30, (self.view.frame.size.width - 100)/2, 40);
    [_button setTitle:@"点一点试试" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTransform:CGAffineTransformIdentity];
    
    [_button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(ls) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
}

- (void)ls
{
    NSLog(@"点击了");
    [self dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:1 animations:^{
            self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        }];
        
        /*
         UIModalTransitionStyleCoverVertical          UIModalTransitionStyleFlipHorizontal
         UIModalTransitionStyleCrossDissolve,
         UIModalTransitionStylePartialCurl
         */
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
