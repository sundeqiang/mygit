//
//  TitleCollectionViewCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.titleLable = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, (SizeW - 20)/2, 30) text:nil textColor:[UIColor cyanColor] font:[UIFont systemFontOfSize:15]];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLable];
    }
    return self;
}

@end
