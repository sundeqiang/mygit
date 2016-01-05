//
//  RecordTableViewCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordTableViewCell : UITableViewCell

{
    UIImageView *_imageView;
    UIImageView *_bigImageView;
    UILabel * _timeLable;
    UILabel *_titleLable;
    UILabel *_detailLable;
    
}

- (void)refreshUI:(RecordModel *)model;

@end
