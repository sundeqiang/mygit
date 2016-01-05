//
//  RecordTableViewCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    //投标图
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 50, 50) imageName:@""];
    [self.contentView addSubview:_imageView];
    //大图
    _bigImageView = [FactoryUI createImageViewWithFrame:CGRectMake(5, _imageView.frame.size.height + _imageView.frame.origin.y + 10, SizeW - 10, 200) imageName:@"shili15"];
    [self.contentView addSubview:_bigImageView];
    //名字
    _titleLable = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 10, _imageView.frame.size.height/2 + _imageView.frame.origin.y, 70, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLable];
    //时间
    _timeLable = [FactoryUI createLabelWithFrame:CGRectMake(_titleLable.frame.origin.x + _titleLable.frame.size.width + 100, _titleLable.frame.origin.y, 120, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:11]];
//    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLable];
    //描述
    _detailLable = [FactoryUI createLabelWithFrame:CGRectMake(5, _bigImageView.frame.origin.y + _bigImageView.frame.size.height + 15, SizeW - 10, 80) text:nil textColor:[UIColor blueColor] font:[UIFont systemFontOfSize:15]];
    _detailLable.numberOfLines = 0;
    _detailLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_detailLable];
    
}

- (void)refreshUI:(RecordModel *)model{
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_url] placeholderImage:nil];
    _titleLable.text = model.publisher_name;
    _timeLable.text = model.pub_time;
    _detailLable.text = model.text;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
