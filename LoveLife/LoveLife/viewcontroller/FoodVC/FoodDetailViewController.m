//
//  FoodDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailModel.h"
#import "FoodDetailTableViewCell.h"
#import "FoodModel.h"

@interface FoodDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_headImageView;
    UILabel *_headLableName;
    UILabel *_headLableTitle;
    FoodDetailModel *_model;
}
@property (nonatomic ,strong) NSMutableArray *headDataArray;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end

@implementation FoodDetailViewController


- (void)dealloc
{
    _tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNVC];
    [self createUI];
    [self getData];
    
}

- (void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"dishes_id": self.dataID, @"methodName": @"DishesView"};
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
            for (NSDictionary *dict in responseObject[@"data"][@"step"]) {
                FoodDetailModel *model = [[FoodDetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
            }
            [_tableView reloadData];
            
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setNVC{
   
    self.navigationItem.title = self.title;
}

- (void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    UIView *bgView = [FactoryUI createViewWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor whiteColor];
    _headImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SizeW, SizeH - 100) imageName:nil];
    [bgView addSubview:_headImageView];
    _headLableName = [FactoryUI createLabelWithFrame:CGRectMake(10, _headImageView.frame.size.height + _headImageView.frame.origin.y + 15, 70, 30) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]];
    _headLableName.text = _model.dishes_name;
    [bgView addSubview:_headLableName];
    _headLableTitle = [FactoryUI createLabelWithFrame:CGRectMake(10, _headLableName.frame.size.height + _headLableName.frame.origin.y + 20, SizeW, 60) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    _headLableTitle.text = _model.dishes_step_desc;
    [bgView addSubview:_headLableTitle];
    _tableView.tableHeaderView = bgView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[FoodDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    FoodDetailModel *model = self.dataArray[indexPath.row];
    [cell refreshUI:model];
    return cell;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
