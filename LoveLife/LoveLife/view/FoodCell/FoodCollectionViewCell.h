//
//  FoodCollectionViewCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodModel;
@protocol playDelegate <NSObject>

- (void)play:(FoodModel *)model;

@end

@interface FoodCollectionViewCell : UICollectionViewCell
{
    //图片
    UIImageView *_imageView;
    //标题
    UILabel *_titleLable;
    //描述
    UILabel *_detailLable;
}
- (void)refeshUI:(FoodModel *)model;
//代理修饰符用weak是防止循环引用导致的内存泄露arc下的strong和weak相当于mrc下的retain和assign
@property(nonatomic ,weak) id<playDelegate>delegate;

//@property (nonatomic ,strong) UIImageView  *imageView;
//
//
//@property (nonatomic, strong) UILabel * titleLable;

@end
