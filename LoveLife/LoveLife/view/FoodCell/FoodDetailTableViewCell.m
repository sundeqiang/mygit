//
//  FoodDetailTableViewCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "FoodDetailTableViewCell.h"
#import "FoodDetailModel.h"

@implementation FoodDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10,0 , SizeW - 20, 50) imageName:nil];
    [self.contentView addSubview:_imageView];
    _title = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y + 2, SizeW - 20, 30) text:nil textColor:[UIColor brownColor] font:[UIFont systemFontOfSize:13]];
    _title.numberOfLines = 0;
    [self.contentView addSubview:_title];
}


- (void)refreshUI:(FoodDetailModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
    _title.text =model.dishes_step_desc;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
