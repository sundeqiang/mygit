//
//  HomeTableViewCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;


@interface HomeTableViewCell : UITableViewCell

{
    UIImageView *_imageView;
    UILabel *_titleLable;
}

- (void)refreshUI:(HomeModel *)homeModel;

@end
