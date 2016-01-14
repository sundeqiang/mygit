//
//  ViewController.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "ViewController.h"
#import "BaseToolViewController.h"
#import "StauteBarViewController.h"
#import "MapViewController.h"
#import "MakePrintView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
}
@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self createUI];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"2"];
    cell.textLabel.text = @"简单控件";
    cell.textLabel.textColor = [UIColor greenColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.detailTextLabel.text = @"真的是简单的";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor cyanColor];
    cell.contentMode = UIViewContentModeCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            BaseToolViewController *baseTool = [[BaseToolViewController alloc]init];
            [self.navigationController pushViewController:baseTool animated:YES];
             // completion:^{
//                baseTool.view.backgroundColor = [UIColor greenColor];
//                [UIApplication sharedApplication].statusBarHidden = YES;
//            }];
        }
            break;
        case 1:{
            StauteBarViewController *svc = [[StauteBarViewController alloc]init];
            [self presentViewController:svc animated:YES completion:nil];
        }
            break;
        case 2:{
            MapViewController *map = [[MapViewController alloc]init];
            [self presentViewController:map animated:YES completion:nil];
        }
            break;
        case 3:{
            MakePrintView *vc = [[MakePrintView alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
            break;
        case 6:{
            
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
