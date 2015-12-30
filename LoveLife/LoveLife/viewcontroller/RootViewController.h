//
//  RootViewController.h
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic, strong) UIButton* leftButton;

@property (nonatomic ,strong) UILabel *titleLable;

@property (nonatomic ,strong) UIButton *rightButton;
//响应事件
- (void)setLeftButtonclick:(SEL )selector;

- (void)setrightButtonclick:(SEL )selector;

@end
