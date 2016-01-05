
//
//  MusicCollectionReusableView.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "MusicCollectionReusableView.h"

@implementation MusicCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.titleLable = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) text:nil textColor:[UIColor cyanColor] font:[UIFont systemFontOfSize:15]];
        [self addSubview:self.titleLable];
    }
    return self;
}

@end
