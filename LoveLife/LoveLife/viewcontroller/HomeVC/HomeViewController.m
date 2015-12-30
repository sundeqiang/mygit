//
//  HomeViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "HomeViewController.h"
//打开抽屉
#import "UIViewController+MMDrawerController.h"
//二维码扫描
#import "CustomViewController.h"
//广告轮播
#import"Carousel.h"

#import "HomeModel.h"

#import "HomeTableViewCell.h"

#import "HomeDetailViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end

@implementation HomeViewController
{
    Carousel *_cycPlaying;
    UITableView *_tableview;
    //分页
    int _page;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNVC];
    [self createTablviewHeaaderView];
    [self createTabView];
    [self createRefresh];
}
- (void)createRefresh{
    _tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self  refreshingAction:@selector(LoadNewData)];
    _tableview.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self  refreshingAction:@selector(loadMoreData)];
    [_tableview.header beginRefreshing];

}
//下拉刷新
- (void)LoadNewData{
    _page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}
//上啦加载
- (void)loadMoreData{
    _page ++;
   [self getData];
}


- (void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      NSLog(@"%@",responseObject);
        for (NSDictionary *dict in responseObject[@"data"][@"topic"]) {
            HomeModel *model = [[HomeModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        //数据请求成功之后停止刷新，刷新界面
        if (_page == 1){
            [_tableview.header endRefreshing];
        }else{
            [_tableview.footer endRefreshing];
        }
        [_tableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } ];
}
#pragma mark - 创建tabview
- (void)createTabView{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH - 49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    //修改分割线
//    //1
//    _tableview.separatorColor = [UIColor clearColor];
//    //2
//    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉多余的线
//    _tableview.
    /*
     UITableViewCellSeparatorStyleNone,
     UITableViewCellSeparatorStyleSingleLine,
     UITableViewCellSeparatorStyleSingleLineEtched
     */
    _tableview.tableHeaderView = _cycPlaying;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell){
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
        
    }
    //赋值
    if (self.dataArray){
        HomeModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController *de = [[HomeDetailViewController alloc]init];
    HomeModel *model = self.dataArray[indexPath.row];
    de.hidesBottomBarWhenPushed = YES;
    de.dataID = model.dataID;
    [self.navigationController pushViewController:de animated:YES];
}

- (void)createTablviewHeaaderView{
    _cycPlaying = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH/3)];
    //是否需要PageControl
    _cycPlaying.needPageControl = YES;
    //是否需要轮播
    _cycPlaying.infiniteLoop = YES;
    //设置PageControl的位置
    _cycPlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    //设置轮播的图片数组，本地使用imageArray 网络使用imageurlArray
    _cycPlaying.imageArray = @[@"shili8",@"shili0",@"shili13",@"shili15",@"shili19"];
}

#pragma mark -----设置导航------
- (void)settingNVC{
    self.titleLable.text = @"悦生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    //设置点击事件
    [self setLeftButtonclick:@selector(leftbuttoncl)];
    [self setrightButtonclick:@selector(ringhtBu)];
}

- (void)leftbuttoncl{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)ringhtBu{
    CustomViewController *vc = [[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isSuceed) {
        if (isSuceed){
            NSLog(@"%@",result);
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
