//
//  ReadViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "ReadViewController.h"
#import "RecordViewController.h"
#import "ArticleViewController.h"

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UISegmentedControl *_segment;
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setNVC];
    [self createUI];
}

- (void)setNVC{
    //创建seg
    _segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //插入标题
    [_segment insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
     [_segment insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    //字体颜色
    _segment.tintColor = [UIColor whiteColor];
//    _segment.backgroundColor = [UIColor whiteColor];
    _segment.selectedSegmentIndex = 0;
    //响应方法
    [_segment addTarget:self  action:@selector(changedOption:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
}
#pragma mark -----创建UI
- (void)createUI{
    //创建scroll
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH)];
    //实质分页
    _scrollView.pagingEnabled = YES;
    //隐藏滑动指示条
    _scrollView.showsHorizontalScrollIndicator =  NO;
//    _scrollView.bounces = NO;
    //关闭滑动效果
//    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(SizeW*2, 0);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    //实例化子控制器
    ArticleViewController *artVC = [[ArticleViewController alloc]init];
    RecordViewController *recVC = [[RecordViewController alloc]init];
    NSArray *VCArr = @[artVC,recVC];
    //滚动式的框架实现
    int i = 0;
    for (UIViewController *vc in VCArr) {
        vc.view.frame = CGRectMake(i*SizeW, 0, SizeW, SizeH);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i ++;
    }
}
- (void)changedOption:(UISegmentedControl *)segControl{
    _scrollView.contentOffset = CGPointMake(segControl.selectedSegmentIndex*SizeW, 0);
    
//    if (segControl.selectedSegmentIndex == 1){
//        _scrollView.contentOffset = CGPointMake(SizeW, 0);
//    }else{
//        _scrollView.contentOffset = CGPointMake(0, 0);
//    }
}
//滑动时
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _segment.selectedSegmentIndex = scrollView.contentOffset.x/SizeW;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
