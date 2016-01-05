//
//  ArticViewCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ArticViewCell : UITableViewCell

{
    //图片
    UIImageView *_imageView;
    UILabel *_timeLable;
    UILabel *_autherLable;
    UILabel *_titleLable;
}

- (void)refreshUI:(ReadModel *)model;

- (void)refreshUI:(ReadModel *)model indexPath:(NSIndexPath *)indexPath;

@end
