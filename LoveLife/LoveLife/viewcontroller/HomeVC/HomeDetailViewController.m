
//
//  HomeDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //头部图片
    UIImageView *_headImageView;
    //头部文字
    UILabel *_headTitleLable;
}
//头视图数据
@property (nonatomic ,strong) NSMutableDictionary * dictData;
//tableView的数据
@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNVC];
    [self createUI];
    [self loadData];
}

- (void)loadData{
    self.dictData = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,[self.dataID intValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //头数图数据
        self.dictData = responseObject[@"data"];
        //taview的数据
        self.dataArray = self.dictData[@"product"];
        //刷新界面
        [self reloadHeadData];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)reloadHeadData{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.dictData[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    _headTitleLable.text = self.dictData[@"desc"];
}

- (void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _headImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SizeW, SizeH/3) imageName:nil];
    _headTitleLable = [FactoryUI createLabelWithFrame:CGRectMake(0, _headImageView.frame.size.height - 49, SizeW, 40) text:nil textColor:[UIColor yellowColor] font:[UIFont systemFontOfSize:10]];
    _headTitleLable.numberOfLines = 0;
    _tableView.tableHeaderView = _headImageView;
    
    [_tableView.tableHeaderView addSubview:_headTitleLable];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *seconArray = self.dataArray[section][@"pic"];
    return seconArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell ){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIImageView *imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SizeW - 20, 200) imageName:nil];
        imageView.tag = 10;
        [cell.contentView addSubview:imageView];
    }
    //赋值
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    if (self.dataArray){
        NSArray *sectionArray = self.dataArray[indexPath.section][@"pic"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SizeW, 60) imageName:nil];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *indexLable = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section + 1 ] textColor:[UIColor greenColor] font:[UIFont boldSystemFontOfSize:15]];
    indexLable.layer.borderColor = RGB(255, 156, 187, 1).CGColor;
    indexLable.layer.borderWidth = 2;
    [bgView addSubview:indexLable];
    //标题
    UILabel *titleLable = [FactoryUI createLabelWithFrame:CGRectMake(indexLable.frame.size.width + indexLable.frame.origin.x + 10, 10, 200, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont boldSystemFontOfSize:15]];
    titleLable.numberOfLines = 0;
    indexLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLable];
    //价钱
    UIButton *pricebutton = [FactoryUI createButtonWithFrame:CGRectMake(SizeW - 60, 10, 60, 40) title:nil titleColor:[UIColor cyanColor] imageName:nil backgroundImageName:nil target:self selector:@selector(priceButtonClick)];
    [bgView addSubview:pricebutton];
    
    //赋值
    [pricebutton setTitle:[NSString stringWithFormat:@"$%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];
    titleLable.text = self.dataArray[section][@"title"];
    return bgView;
}

- (void)priceButtonClick{
    UIViewController *vc = [[UIViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (void)setNVC{
    self.titleLable.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self setLeftButtonclick:@selector(leftButtonClinck)];
//    [self.navigationItem.leftBarButtonItem setCustomView:self.leftButton];
}

- (void)leftButtonClinck{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
@end
