//
//  GuidePageView.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "GuidePageView.h"

@interface GuidePageView ()

@property (nonatomic ,strong) UIScrollView *scroller;

@end


@implementation GuidePageView
//重写系统方法
- (instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]){
        //创建scrollView
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH + 64)];
        //整页滑动
        _scroller.pagingEnabled = YES;
        //滑动范围
        _scroller.contentSize = CGSizeMake(imageArray.count *SizeW, SizeH + 64);
        [self addSubview:_scroller];
        //创建imageView
        for (int i = 0; i < imageArray.count; i ++)   {
            UIImageView * imageView=[FactoryUI createImageViewWithFrame:CGRectMake(i*SizeW, 0, SizeW, SizeH+64) imageName:imageArray[i]];
            [_scroller addSubview:imageView];
            if (i==imageArray.count-1)
            {
                self.goInButton =[UIButton buttonWithType:UIButtonTypeCustom];
                self.goInButton.frame = CGRectMake(100, 100, 50, 50);
                [self.goInButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                imageView.userInteractionEnabled=YES;
                [imageView addSubview:self.goInButton];
            }
        }
    }
    return self;
}
@end
