//
//  MusicPlayViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "MusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface MusicPlayViewController ()<AVAudioPlayerDelegate>
{
    UISlider *_slider;
    AVAudioPlayer *_AVPlayer;
    NSTimer *_timer;
}
@end

@implementation MusicPlayViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"welcome3"]];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //图片小就会平铺
    
    [self createUI];
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //启用异步方法
    dispatch_group_async(group, queue, ^{
        [self createAVAudioPlayer];
    });

//    [self createAVAudioPlayer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sliderValueChange) userInfo:nil repeats:YES];
    //设置后台播放模式 AVAudioSession指的是音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //在后台保持活跃
    [session setActive:YES error:nil];
    
    //拔出耳机后停止播放，观察者模式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isHasDevice:) name:AVAudioSessionRouteChangeNotification  object:nil];
    
}
#pragma  mark -- 监听是否有耳机
- (void)isHasDevice:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            if ([_AVPlayer isPlaying])
            {
                [_AVPlayer pause];
                _timer.fireDate=[NSDate distantFuture];
            }
        }
    }
}

#pragma mark - AVauduo代理
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag){
        //正常播放完毕
        
    }else
    {
        //音频文件播放完了，但是数据解码错误
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"音频对话错误");
}

//ios8之前方法废弃啦，之后自动处理
//开始被中断，比如说用户home建返回或者突然地来电
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    //暂停播放器
    [_AVPlayer pause];
}
//回到播放器，继续播放
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    [_AVPlayer play];
}

//


#pragma mark ----  创建音乐播放器
- (void)createAVAudioPlayer{
    //NSURL创建 播放本地的音频URL
//    _AVPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:@""] fileTypeHint:<#(NSString * _Nullable)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    _AVPlayer = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlArray[_currentIndex]]] error:nil];
    //代理
    _AVPlayer.delegate = self;
    //音量（0-1之间）
    _AVPlayer.volume = 0.5;
    //设置当前播放进度
    _AVPlayer.currentTime = 0;
    //设置循环次数
    _AVPlayer.numberOfLoops = -1;//负数表示无线播放 0表示拨一次 正数是几就几次
    
//    _AVPlayer.isPlaying //是否在播放
//    _AVPlayer.numberOfChannels;//声道数
//    _AVPlayer.duration//持续时间
    //准备播放
    [_AVPlayer prepareToPlay];
}

#pragma mark --- 创建UI
- (void)createUI
{
    //返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 20, 30, 30) title:nil titleColor:nil imageName:@"iconfont-fanhui" backgroundImageName:nil target:self selector:@selector(backButtonClick)];
    [self.view addSubview:backButton];
    
    //标题
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 40, SizeW, 30) text:self.model.title textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:22]];
    titleLabel.textAlignment= NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //演唱者
    UILabel * authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(SizeW - 100, titleLabel.frame.size.height + titleLabel.frame.origin.y + 10, 90, 20) text:self.model.artist textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
    authorLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:authorLabel];
    
    //图片
    UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, authorLabel.frame.size.height + authorLabel.frame.origin.y + 5, SizeW - 20, SizeH - 20) imageName:nil];
    //赋值
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageView];
    
    //指示条
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, imageView.frame.size.height + imageView.frame.origin.y + 40, SizeW- 20, 20)];
    //设置初始时的value
    _slider.value = 0.0;
    //添加事件
    [_slider addTarget:self action:@selector(changedOption:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    
    //创建按钮
    NSArray * buttonImageArray = @[@"iconfont-bofangqishangyiqu",@"iconfont-musicbofang",@"iconfont-bofangqixiayiqu"];
    for (int i = 0; i < buttonImageArray.count; i ++) {
        UIButton * button = [FactoryUI createButtonWithFrame:CGRectMake(70 + i * 90, 300, 40, 40) title:nil titleColor:nil imageName:buttonImageArray[i] backgroundImageName:nil target:self selector:@selector(playButtonClick:)];
        button.tag = 100 + i;
        [self.view addSubview:button];
    }
    
    
}
/*{
    //返回按钮
    UIButton *backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 10, 30, 30) title:nil titleColor:[UIColor darkGrayColor] imageName:@"" backgroundImageName:nil target:self selector:@selector(blckButton)];
    [self.view addSubview:backButton];
    //演唱者
    UILabel *auther = [FactoryUI createLabelWithFrame:CGRectMake(50, 10, 60, 30) text:self.model.artist textColor:[UIColor blueColor] font:[UIFont systemFontOfSize:15]];
    auther.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:auther];
    
    //标题
    UILabel *titleLable = [FactoryUI createLabelWithFrame:CGRectMake(100, 10, 60, 30) text:self.model.title textColor:[UIColor greenColor] font:[UIFont systemFontOfSize:12]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLable];
    //图片
    UIImageView *imageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SizeW, SizeH) imageName:nil];
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverURL] placeholderImage:nil];
    //芝士条
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 300, SizeW - 20, 20)];
    //设置初始化的value
    _slider.value = 0.0;
    
    [_slider addTarget:self action:@selector(changedOption:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    //创建button
    NSArray *buttonArr = @[@"iconfont-bofangqishangyiqu",@"iconfont-musicbofang",@"iconfont-bofangqixiayiqu"];
    for (int i = 0; i < buttonArr.count; i ++ ) {
        UIButton *button = [FactoryUI createButtonWithFrame:CGRectMake(100 + i*60, _slider.frame.size.height + _slider.frame.origin.y + 20,40 , 40) title:nil titleColor:[UIColor redColor] imageName:buttonArr[i] backgroundImageName:nil target:self selector:@selector(playButtonClick:)];
        button.tag = 100 + i;
        [self.view addSubview:button];
    }
}*/

- (void)playButtonClick:(UIButton *)button{
    switch (button.tag - 100) {
        case 0:
            //上一首
            //停止当前歌曲
            [_AVPlayer stop];
            if (_currentIndex == 0){
                _currentIndex = (int)self.urlArray.count - 1;
            }
            _currentIndex --;
            [self createAVAudioPlayer];
            [_AVPlayer play];
            [self oldMusic];
            break;
        case 1:
            //播放/暂停
            //判断如果正在播放，则暂停，改变按钮的状态为播放
            if (_AVPlayer .isPlaying){
                [button setImage:[UIImage imageNamed:@"iconfont-musicbofang"] forState:UIControlStateNormal];
                [_AVPlayer pause];
//                [_timer setFireDate:[NSData distantFuture]];//定时器暂停
                
            }else
            {
                [button setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateNormal];
                [_AVPlayer play];
//                [_timer setFireDate:[NSData distantPast] ];
//                [_timer invalidate];//销毁定时器不可以再用
            }
            [self playMusic];
            break;
        case 2:
            //下一首
            [_AVPlayer stop];
            if (_currentIndex == self.urlArray.count - 1){
                _currentIndex = 0;
            }
            _currentIndex ++ ;
            [self createAVAudioPlayer];
            [_AVPlayer play];
            
            [self newMusic];
            break;
        default:
            break;
    }
    
    
}

- (void)oldMusic{
    
}

- (void)playMusic{
        if (_AVPlayer.isPlaying){
            
        }
}

- (void)newMusic{

    
}

#pragma mark -- 定时监测死了的人的value值
- (void)sliderValueChange{
    _slider.value = _AVPlayer.currentTime/_AVPlayer.duration;
}
#pragma mark -- 指示条
- (void)changedOption:(UISlider*)siler
{
    _AVPlayer.currentTime = _AVPlayer.duration*_slider.value;
}

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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
