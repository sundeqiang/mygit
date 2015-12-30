//
//  GuidePageView.h
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageView : UIView

@property (nonatomic ,strong) UIButton *goInButton;

- (instancetype) initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray;

@end
