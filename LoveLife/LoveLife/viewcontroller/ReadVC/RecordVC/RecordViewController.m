//
//  RecordViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordModel.h"
#import "RecordTableViewCell.h"

@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    int _page;
    
}

@property (nonatomic, strong) NSMutableArray* dataArray;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self creatRefresh];
    
}
- (void)creatRefresh{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
}
//下拉刷新
- (void)loadNewData{
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
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"content"];
        for (NSDictionary *dic in array) {
            RecordModel *model = [[RecordModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        if (_page == 1){
            [_tableView.header endRefreshing];
        }else
        {
            [_tableView.footer endRefreshing];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark ---tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    RecordModel *model = self.dataArray[indexPath.row];
    [cell refreshUI:model];
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell ){
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];    }
//    cell.textLabel.text = @"aadsad";
//    cell.detailTextLabel.text = @"asfsa";
//    cell.imageView.image = [UIImage imageNamed:@"5"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 360;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    cell.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeRotation(-50, 200, 200, 100);
    }];
    
 
}

@end
