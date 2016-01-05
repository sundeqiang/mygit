//
//  MusicViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "MusicViewController.h"
#import "MusizCollectionViewCell.h"
#import "MusicCollectionReusableView.h"
#import "MusicDateilViewController.h"


@interface MusicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectView;
}
@property (nonatomic ,strong) NSArray *nameArray;
@property (nonatomic ,strong) NSArray *urlArray;
@property (nonatomic ,strong) NSArray*imageArray;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArray];
    [self setNAc];
    [self createUI];
}

- (void)createUI{
    //创建网格布局对象
    UICollectionViewFlowLayout *flou = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    flou.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建网格对象
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SizeW , SizeH) collectionViewLayout:flou];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_collectView];
    //注册cel类
    [_collectView registerClass:[MusizCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册header
    [_collectView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
        //footer
    [_collectView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"view"];
}

#pragma mark -- 代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//确定每个section所对应的item地个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusizCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.item]]];
    cell.titleLable.text = self.nameArray[indexPath.item];
    return cell;
}

//设置item的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake((SizeW - 20)/2, 150);
}
//不设置默认是10
//垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//四周的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//设置header大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

//设置header和footer的view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MusicCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader){
        view.titleLable.text = @"端头";
        view.titleLable.textColor = [UIColor redColor];
    }else{
        view.titleLable.text = @"段位";
        view.titleLable.textColor = [UIColor brownColor];
    }
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicDateilViewController *dateil = [[MusicDateilViewController alloc]init];
    //传值
    dateil.tyedString = self.nameArray[indexPath.item];
    dateil.urlString = self.urlArray[indexPath.item];
    dateil.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dateil animated:YES];
    
}

- (void)setNAc{
    self.titleLable.text = @"音乐";
}

- (void)initArray{
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
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
