//
//  BaseToolViewController.m
//  知识大综合_Demo
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "BaseToolViewController.h"
#import "DeleteTableViewViewController.h"
#import "UILableViewController.h"
#import "ButtonViewController.h"
#import "CustameView.h"

@interface BaseToolViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation BaseToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 120;
//    self.dataSource = [[NSMutableArray alloc]initWithObjects:@20, nil];
//    [_tableView registerClass:[BaseToolViewController class] forCellReuseIdentifier:@"ID"];
//    [_tableView setEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
//    return 20self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string  = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor purpleColor];
    cell.imageView.image = [UIImage imageNamed:@"2"];
    cell.textLabel.text = @"各种控件";
    cell.textLabel.textColor = [UIColor greenColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = @"详细而简单的";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.contentMode = UIViewContentModeCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
                       DeleteTableViewViewController *deleteTableView = [[DeleteTableViewViewController alloc]init];
//            UINavigationController *nvvc= [[UINavigationController alloc]initWithRootViewController:deleteTableView];
            
            [self.navigationController pushViewController:deleteTableView animated:YES];
        }
            break;
        case 1:
        {
            UILableViewController * vc = [[UILableViewController alloc]init];
            [self presentViewController:vc animated:YES completion:^{
                self.modalPresentationStyle = UIModalPresentationFormSheet;
                /*
                 UIModalPresentationFullScreen = 0,
                 UIModalPresentationPageSheet                  UIModalPresentationFormSheet                  UIModalPresentationCurrentContext
                 UIModalPresentationCustom
                 UIModalPresentationOverFullScreen
                 UIModalPresentationOverCurrentContext
                 UIModalPresentationPopover
                 UIModalPresentationNone
                 */
            }];
        }
            break;
        case 2:
        {
            ButtonViewController *vc = [[ButtonViewController alloc]init];
            [self presentViewController:vc animated:YES completion:^{
                vc.view.backgroundColor = [UIColor whiteColor];
                self.modalPresentationStyle = UIModalPresentationOverFullScreen;
            }];
        }
            break;
        case 3:
        {
            CustameView *vc = [[CustameView alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

@end
