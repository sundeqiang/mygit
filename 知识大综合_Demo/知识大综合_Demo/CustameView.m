//
//  CustameView.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "CustameView.h"

@interface CustameView ()
{
    UITapGestureRecognizer *_tap;
    UIView *_view;
}
@end

@implementation CustameView

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return 0;
}

- (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict
{
    
}

//- (void)loadView
//{
//
//   self.view.backgroundColor = [UIColor redColor];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor cyanColor];
    //创建普通View
    //    [self aboutFrame];
    //    [self superView];
    //层次关系
    //[self levels];
    //简单动画
    //    [self baseAnimation];
    //复杂啊动画
    [self fuzaAnimation];
    //layer
    //    [self baseLayer];
}
#warning 有问题没有解决啊啊啊啊啊啊！！！！！
//复杂动画
- (void)fuzaAnimation{
    _view = [[UIView alloc]initWithFrame:CGRectMake(20, 50,60 , 60)];
    _view.layer.cornerRadius = 30;
    _view.layer.shadowOpacity = 0.6;
    _view.layer.borderWidth = 10;
    _view.layer.borderColor = [UIColor redColor].CGColor;
    _view.layer.shadowColor = [UIColor blackColor].CGColor;
    _view.layer.shadowRadius = 15;
    _view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_view];
    
    [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        CGRect frame = _view.frame;
        frame.origin.x = 20;
        frame.origin.y = self.view.frame.size.height - 50;
        frame.size.width = 200;
        frame.size.height = 50;
        _view.frame = frame;
        
        [UIView setAnimationRepeatAutoreverses:5];
        for (int i = 0; i < frame.origin.y; i ++ ) {
            if ((float)_view.frame.origin.y ){
                self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
            }
        }
        //        for (int j = 0; j < 50; j++) {
        for (int i = 0; i < 200; i ++) {
            _view.transform = CGAffineTransformMakeRotation([self degress:180.0 *i]);
        }
        //        }
        
    } completion:^(BOOL finished) {
        //
        //        [UIView setAnimationRepeatCount:6];
        [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
            
        } completion:^(BOOL finished) {
            CGRect frame = _view.frame;
            frame.origin.x = 240;
            frame.origin.y = 20;
            frame.size.width = 100;
            frame.size.height = 100;
            _view.frame = frame;
            
            [UIView setAnimationRepeatAutoreverses:5];
            for (int i = (int)_view.frame.origin.y; i > frame.origin.y; i -- ) {
                if ((float)_view.frame.origin.y ){
                    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
                }
            }
            //        for (int j = 0; j < 50; j++) {
            for (int i = 0; i < 200; i ++) {
                _view.transform = CGAffineTransformMakeRotation([self degress:180.0 *i]);
            }
        }];
        [self ls];
    }];
    
}

//layer
- (void)baseLayer{
    // 创建一个view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
}

- (void)baseAnimation{
    _view = [[UIView alloc]initWithFrame:CGRectMake(20, 50,60 , 60)];
    _view.layer.cornerRadius = 30;
    _view.layer.shadowOpacity = 0.6;
    _view.layer.shadowColor = [UIColor orangeColor].CGColor;
    _view.layer.shadowRadius = 5;
    _view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_view];
    //创建动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:10];
    //延时
    [UIView setAnimationDelay:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ls)];
    [UIView setAnimationWillStartSelector:@selector(ll)];
    [UIView setAnimationRepeatCount:3];
    CGRect frame = _view.frame;
    frame.origin.x = 200;
    frame.origin.y = self.view.frame.size.height - 50;
    frame.size.width = 200;
    frame.size.height = 50;
    _view.frame = frame;
    for (int i = 0; i < self.view.frame.origin.y; i ++ ) {
        if ((float)_view.frame.origin.y ){
            self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        }
    }
    _view.backgroundColor = [UIColor yellowColor];
    _view.alpha = 0.6;
    [UIView commitAnimations];
    
    
    
}

- (void)ls{
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"提示" message:@"动画结束啦" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    NSLog(@"%@",action.title);
    [aler addAction:action];
    [self presentViewController:aler animated:YES completion:nil];
    
}

- (void)ll{
    //    UIDynamicAnimator *an = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    NSLog(@" 卡IIShi啊");
}

//- (void)animationDidStart:(CAAnimation *)anim
//{
//    if (_view.frame.size.height/10 == 0){
//        self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    }
//}

//层次关系
- (void)levels{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 40, 250, 250)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    //桔黄色色
    UILabel *laOringe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 50)];
    laOringe.backgroundColor = [UIColor orangeColor];
    [view addSubview:laOringe];
    //蓝色
    UILabel *labule = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 200)];
    labule.backgroundColor = [UIColor blueColor];
    [view addSubview:labule];
    //红色
    UILabel *lared = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    lared.backgroundColor = [UIColor redColor];
    [view addSubview:lared];
    //    [view insertSubview:laOringe aboveSubview: lared];
    [view insertSubview:labule atIndex:2];
    for (int i = 0; i < view.subviews.count; i++) {
        UILabel *la = [view.subviews objectAtIndex:i];
        la.text = [NSString stringWithFormat:@"我是第%d层",i];
        la.textColor = [UIColor blackColor];
        
    }
}

- (void)superView
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 200, 200)];
    view1.tag = 10;
    view1.backgroundColor = [UIColor blueColor];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(50, 30,220, 60)];
    view2.backgroundColor = [UIColor yellowColor];
    //    view1.bounds = CGRectMake(40, 20, 50, 60);
    view1.frame = CGRectMake(30, 30, 300, 400);
    [view1 addSubview:view2];
    //    view1.clipsToBounds = YES;
    view2.alpha = 0.3;
    [self.view addSubview:view1];
    NSLog(@"父视图 %ld" ,view1.tag);
    NSLog(@"%@",view1.subviews);
    BOOL isSon = [view2 isDescendantOfView:view1];
    NSLog(@"%d",isSon);
}
- (void)aboutFrame
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, 40, 150, 150) ];
    view.backgroundColor = [UIColor redColor];
    view.center = self.view.center;
    //    view.frame = CGRectMake(50, 30, 100, 100);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    //    view.layer.shadowOffset = CGSizeMake(4, 4);
    //透明度
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 4;
    [self.view addSubview:view];
    for (int i = 0; i < 100; i ++ ) {
        [UIView animateWithDuration:4 animations:^{
            
            view.transform = CGAffineTransformMakeRotation([self degress:180 *i ]);
        }];
        
    }
    
    
    _tap.numberOfTapsRequired = 3;
    _tap.numberOfTouchesRequired = 2;
}

- (CGFloat)degress:(CGFloat)deg
{
    CGFloat angle;
    angle = deg*M_PI / 180;
    return angle;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end