//
//  FoodDetailTableViewCell.h
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodDetailModel;
@interface FoodDetailTableViewCell : UITableViewCell

{
    UIImageView *_imageView;
    UILabel *_title;
}

- (void)refreshUI:(FoodDetailModel *)model;

@end
