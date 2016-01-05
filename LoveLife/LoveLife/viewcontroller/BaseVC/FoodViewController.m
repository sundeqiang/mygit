//
//  FoodViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "FoodCollectionViewCell.h"
#import "TitleCollectionViewCell.h"
#import "FoodModel.h"
#import "MpViewController.h"
//视频播放
#import <MediaPlayer/MediaPlayer.h>
//ios9下的播放框架
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FoodDetailViewController.h"

@interface FoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout,playDelegate>
{
    UICollectionView *_collectionView;
    //分类id
    NSString * _categoryID;
    //标题
    NSString * _titleString;
    //芝士条
    UIView *_liinView;
    
    int _page;
    
}

@property (nonatomic ,strong) NSMutableArray *dataArray;

//button数组
@property (nonatomic, strong) NSMutableArray* buttonArr;
@end

@implementation FoodViewController

- (void)viewWillAppear:(BOOL)animated{
    for (UIButton *btn  in self.buttonArr) {
        if (btn == [self.buttonArr firstObject]){
            btn.selected = YES;
            
            //可以再这设置选种颜色（麻烦）
        }
    }
    self.navigationController.navigationBar.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _collectionView ){
        if (_collectionView.contentOffset.y > SizeH + 64){
            self.navigationController.navigationBar.hidden = NO;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setNVC];
    [self createHeaderView];
    [self createCollectionView];
    [self createRefresh];
}
#pragma mark === 刷新请求数据
- (void)createRefresh{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_collectionView.header beginRefreshing];
}

- (void)loadNewData{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}
- (void)loadMoreData{
    _page ++;
    [self getData];
}

- (void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": _categoryID, @"size": @"20"};
    [manager POST:FOODURL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] intValue] == 0){
            for (NSDictionary *dic in responseObject[@"data"][@"data"]) {
                FoodModel *model = [[FoodModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        if (_page == 0){
            [_collectionView.header endRefreshing];
        }else{
            [_collectionView.footer endRefreshing];
        }
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog( @"%@",error);
    }];
}


- (void)createCollectionView{
    //创建网格布局对象
    NBWaterFlowLayout *flowLayiout = [[NBWaterFlowLayout alloc]init];
    //网格大小
    flowLayiout.itemSize = CGSizeMake((SizeW - 20)/2, 150);
    //设置列数
    flowLayiout.numberOfColumns = 2;
    //代理哦
    flowLayiout.delegate = self;
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, SizeW, SizeH - 40) collectionViewLayout:flowLayiout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //设置背景色（默认是黑色的）
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    //注册cell(第二个是header 和footer注册用的)
    [_collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:@"food"];
    [_collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"title"];
}

#pragma mark --实现collectionView的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //判断是否有值
    
    return self.dataArray ? self.dataArray.count + 1 : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        //标题
        TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"title" forIndexPath:indexPath];
        cell.titleLable.text = _titleString;
        cell.backgroundColor = [UIColor grayColor];
        return cell;
    }else
    {
        //正文
        FoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"food" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        //设置代理
        cell.delegate = self;
        //赋值
        if (self.dataArray){
            FoodModel *model = self.dataArray[indexPath.row - 1];
            [cell refeshUI:model];
        }
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     FoodDetailViewController *de = [[FoodDetailViewController alloc]init];
    FoodModel *model = self.dataArray[indexPath.row];
    de.hidesBottomBarWhenPushed = YES;
    de.dataID = model.dishes_id;
    de.title = model.title;
    [self.navigationController pushViewController:de animated:YES];
}

#pragma mark ---实现自定义的代理方法

- (void)play:(FoodModel *)model
{
   /* //进行视频播放
    //默认
//    MPMoviePlayerViewController *playVC = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //强制横屏播放
    MpViewController *playVc = [[MpViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //准备播放
    [playVc.moviePlayer prepareToPlay];
    //开始播放
    [playVc.moviePlayer play];
    //页面跳转
    [self presentViewController:playVc animated:YES completion:nil];*/
    
    //ios9下的视频播放
    AVPlayerViewController *player = [[AVPlayerViewController alloc]init];
    AVPlayer *avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString: model.video]];
    player.player = avPlayer;
    [self presentViewController:player animated:YES completion:nil];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        return 30 ;
    }else{
        return 190;
    }
    
}

- (void)createHeaderView{
    NSArray *titleArr = @[@"家常菜",@"小炒",@"凉菜",@"烘培"];
//    UIView *bgVIew = [FactoryUI createViewWithFrame
//                      :CGRectMake(0, 0, SizeW, 40)];
    UIImageView *bgVIew = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SizeW, 40) imageName:nil];
    //打开用户交互
    bgVIew.userInteractionEnabled = YES;
    [self.view addSubview:bgVIew];
    bgVIew.backgroundColor = [UIColor whiteColor];
    for (int i = 0 ; i < titleArr.count; i ++) {
        UIButton *headerButton = [FactoryUI createButtonWithFrame:CGRectMake(i *SizeW/4, 0, SizeW/4, 40) title:titleArr[i] titleColor:[UIColor purpleColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerbutton:)];
        headerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置选中状态的颜色
        [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.tag = 10 + i;
        [bgVIew addSubview:headerButton];
        //加到数组
        [self.buttonArr addObject:headerButton];
    }
    _liinView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SizeW/4, 2)];
    _liinView.backgroundColor = [UIColor greenColor];
    [bgVIew addSubview:_liinView];
    
    
}

- (void)headerbutton:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        _liinView.frame = CGRectMake((button.tag - 10)*SizeW/4, 38,SizeW/4 , 2);
    }];
//    button.selected = YES;
    //保证每次点击的时候只选中一个按钮
    for (UIButton *btn in self.buttonArr)
    {
//        button.selected = !btn.selected;
        if (btn.selected == YES)
        
            btn.selected = NO;
        
    }
   button.selected = YES;
    
}
- (void)initData{
    _categoryID = @"1";
    _titleString = @"家常菜";
    self.buttonArr = [NSMutableArray arrayWithCapacity:0];
}

- (void)setNVC{
    self.titleLable.text = @"美食";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
