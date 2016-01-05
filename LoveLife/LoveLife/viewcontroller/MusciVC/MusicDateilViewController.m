
//
//  MusicDateilViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "MusicDateilViewController.h"
#import "MBProgressHUD.h"
#import "musicModel.h"
#import "MusicListCell.h"
#import "MusicPlayViewController.h"

@interface MusicDateilViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    //分页
    int _page;
}

@property (nonatomic ,strong) NSMutableArray  *dataArray;
@property (nonatomic ,strong) MBProgressHUD  *hud;
//mp3文件
@property (nonatomic ,strong) NSMutableArray  *urlArray;

@end

@implementation MusicDateilViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.urlArray = [NSMutableArray arrayWithCapacity:0];
    [self setNVC];
    [self createUI];
    //刚进入页面现实的数据
    [self loadData];
    [self createRefresh];

}

- (void)setNVC{
    self.titleLable.text = self.tyedString;
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self setLeftButtonclick:@selector(leftButtonClick)];
}

- (void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData{
    //活动指示器显示出来
    [self.hud show:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        for (NSDictionary *dic in responseObject[@"data"]) {
            //mp3文件
            [self.urlArray addObject:dic[@"url"]];
            musicModel *model = [[musicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        //数据请求成功后，停止刷新，结束活动只是其，刷新界面
        [_tableView.footer endRefreshing];
        [self.hud hide:YES];
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)createRefresh{
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData{
    _page ++;
    [self loadData];
}

- (void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //创建活动指示器
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    //家在文字
    self.hud.labelText = @"正在加载。。。。。";
    //背景颜色
    self.hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.hud.labelFont = [UIFont systemFontOfSize:12];
    self.hud.labelColor = [UIColor yellowColor];
    //设置中间指示器的颜色
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    [self.view addSubview:self.hud];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell ){
        cell = [[MusicListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (self.dataArray){
        musicModel *model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayViewController *player = [[MusicPlayViewController alloc]init];
    musicModel *model = self.dataArray[indexPath.row];
    player.model = model;
    player.currentIndex = (int)indexPath.row;
    player.urlArray = self.urlArray;
    [self.navigationController pushViewController:player animated:YES];
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
