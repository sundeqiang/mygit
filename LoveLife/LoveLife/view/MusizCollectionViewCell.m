//
//  MusizCollectionViewCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "MusizCollectionViewCell.h"

@implementation MusizCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.imageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) imageName:nil];
    [self.contentView addSubview:self.imageView];
    self.titleLable = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, 30) text:nil textColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
    self.titleLable.center = self.imageView.center;
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLable];
}

@end
