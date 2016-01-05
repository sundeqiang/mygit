//
//  MyViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"
#import "QRCodeGenerator.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_headerImageView;
    //夜间模式的view
    UIView *_darkView;
}

//图标
@property (nonatomic ,strong) NSArray *logoArray;
@property (nonatomic ,strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation MyViewController

static float ImageOrigiHeight = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoArray = @[@"iconfont-iconfontaixinyizhan",@"iconfont-lajitong",@"iconfont-yejianmoshi",@"iconfont-zhengguiicon40",@"iconfont-guanyu"];
    self.titleArray = @[@"我的收藏",@"清理缓存",@"夜间模式",@"推送消息",@"关于"];
    _darkView = [[UIView alloc]initWithFrame:self.view.frame];
    [self settingNVC];
    [self createUI];
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    //Size清晰度
    im.image= [QRCodeGenerator qrImageForString:@"www.baidu.com" imageSize:300];
    [self.view addSubview:im];
}
- (void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SizeW, SizeH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [[UIView alloc]init];
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, -ImageOrigiHeight, SizeW,ImageOrigiHeight) imageName:@"welcome1"];
    [_tableView addSubview:_headerImageView];
    //设置_tableView的内容从ImageOrigiHeight开始显示
    _tableView.contentInset = UIEdgeInsetsMake(ImageOrigiHeight, 0, 0, 0);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        if(indexPath.row == 0|| indexPath.row == 1||indexPath.row == 4){
            //设置尾部
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2 || indexPath.row == 3 ){
            UISwitch *swtch = [[UISwitch alloc]initWithFrame:CGRectMake(SizeW - 60, 5, 50, 30)];
            //设置颜色
            swtch.onTintColor = [UIColor greenColor];
            swtch.tag = indexPath.row;
            [swtch addTarget:self action:@selector(cghangdeClick:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:swtch];
        }
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:self.logoArray[indexPath.row]];
    return cell;
}

- (void)cghangdeClick:(UISwitch *)swith{
    if (swith.tag == 2) {
        //夜间模式
        if (swith.on){
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *delegate = app.delegate;
            //设置背景色
            _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            //关闭view的交互属性
            _darkView.userInteractionEnabled = NO;
            [delegate.window addSubview:_darkView];
        }else
        {
            [_darkView removeFromSuperview];
        }
        
    }
    else
    {
        //清理缓存
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //图头放大
    //思路：通过改变ScrollView的偏移量（contentOffset）来改变图片的frame
    if (scrollView == _tableView){
        // 获取偏移量
        CGFloat yoffset = scrollView.contentOffset.y;
        
        CGFloat xoffset = (yoffset + ImageOrigiHeight)/2;
        if (yoffset < -ImageOrigiHeight){
            CGRect rect = _headerImageView.frame;
            //改变imagevie的frame的值
            rect.origin.y = yoffset;
            rect.size.height = -yoffset;
            rect.origin.x = xoffset;
            //fabs取绝对值
            rect.size.width = SizeW + fabs(xoffset) * 2;
            _headerImageView.frame = rect;
        }
    }
}

- (void)settingNVC{
    self.titleLable.text = @"我的";
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
