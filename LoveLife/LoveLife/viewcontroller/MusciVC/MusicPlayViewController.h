//
//  MusicPlayViewController.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "musicModel.h"
@interface MusicPlayViewController : UIViewController

//传值
@property (nonatomic ,strong) musicModel *model;
//mp3文件
@property (nonatomic ,strong) NSArray  *urlArray;

//index值

@property (nonatomic ,assign)int currentIndex;

@end
