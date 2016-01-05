//
//  FoodCollectionViewCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "FoodCollectionViewCell.h"
#import "FoodModel.h"

@interface FoodCollectionViewCell ()

@property (nonatomic, strong) FoodModel* foodmodel;
@end

@implementation FoodCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self createUI];
    }
    return self;
}
- (void)createUI{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, (SizeW - 20)/2 - 20, 130) imageName:nil];
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
    _titleLable = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y + 5, _imageView.frame.size.width, 20) text:nil textColor:[UIColor redColor] font:[UIFont boldSystemFontOfSize:16]];
    [self.contentView addSubview:_titleLable];
    _detailLable = [FactoryUI createLabelWithFrame:CGRectMake(_titleLable.frame.origin.x, _titleLable.frame.size.height + _titleLable.frame.origin.y, _titleLable.frame.size.width ,20) text:nil textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_detailLable];
    
    UIButton *playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-musicbofang" backgroundImageName:nil target:self selector:@selector(playButtonClick)];
    playButton.center = _imageView.center;
    [_imageView addSubview:playButton];
}
//播放按钮
- (void)playButtonClick{
    //判断当前对象是否有这个方法
    if ([_delegate respondsToSelector:@selector(play:)]){
        [_delegate play:_foodmodel];
    }
}

- (void)refeshUI:(FoodModel *)model{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _titleLable.text = model.title;
    _detailLable.text = model.detail;
}

@end
