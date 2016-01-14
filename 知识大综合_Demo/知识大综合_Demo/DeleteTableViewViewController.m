//
//  DeleteTableViewViewController.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "DeleteTableViewViewController.h"

@interface DeleteTableViewViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    NSMutableArray *_removeArray;
    BOOL _isEditing;
    UIBarButtonItem *_delegateItem;
}
@end

@implementation DeleteTableViewViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    DeleteTableViewViewController *dvc = [[DeleteTableViewViewController alloc]init];
//    UINavigationController *nac = [[UINavigationController alloc]initWithRootViewController:dvc];
    
    _isEditing = NO;
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editClick)];
    self.navigationItem.leftBarButtonItem = editItem;
    _delegateItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteClick)];
    //    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]] ;
    //    [[self navigationItem ] setleftBarButtonItem:[self editButtonItem ]];
    //    self.navigationItem.rightBarButtonItem = _delegateItem;
    //    _dataSource = [[NSMutableArray alloc]initWithCapacity:20];
    _dataSource = [[NSMutableArray alloc]init];
    _removeArray = [[NSMutableArray alloc]init];
    //    _removeArray = [[NSMutableArray alloc]initWithCapacity:20];
    for (int i = 0; i < 20; i ++) {
        NSString *textString = [NSString stringWithFormat:@"这是第%d行",i];
        [_dataSource addObject:textString];
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate  = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    //    [self createUI];
    [self createButton];
    
}

- (void)createButton
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 180, 80, 50, 30)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ls) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)ls
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editClick{
    _isEditing = !_isEditing;
    [_tableView setEditing:_isEditing animated:YES];
    [_removeArray removeAllObjects];
    if (_isEditing){
        self.navigationItem.rightBarButtonItem = _delegateItem;
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)deleteClick{
    [_dataSource removeObjectsInArray:_removeArray];
    [_tableView reloadData];
    
}

- (void)createUI
{
    
    //    _dataSource = [[NSMutableArray alloc]init];
    //    _dataSource = [NSMutableArray array];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate  = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"afafafafsfds";
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    /*UITableViewCellEditingStyleNone,
     UITableViewCellEditingStyleDelete,
     UITableViewCellEditingStyleInsert*/
}

//反选
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"选中啦第%ld个",indexPath.row);
//    _tableView.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1);
//    [UIView animateWithDuration:0.5 animations:^{
//        _tableView.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing){
        NSString *remoStr = [_dataSource objectAtIndex:indexPath.row];
        [_removeArray addObject:remoStr];
    }
}

@end


