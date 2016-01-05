//
//  ArticViewCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "ArticViewCell.h"

@implementation ArticViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return self;
}
//UIImageView *_imageView;
//UILabel *_timeLable;
//UILabel *_autherLable;
//UILabel *_titleLable;
- (void)createUI{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 120, 90) imageName:nil];
    _timeLable = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y, 120, 20) text:nil textColor:[UIColor redColor] font:[UIFont boldSystemFontOfSize:15]];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_timeLable];
    _autherLable = [FactoryUI createLabelWithFrame:CGRectMake(SizeW - 120, _timeLable.frame.origin.y
                                                              , 110, 20) text:nil textColor:[UIColor greenColor] font:[UIFont boldSystemFontOfSize:15]];
    [self.contentView addSubview:_autherLable];
    _titleLable = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width + 10, 30, 200, 40) text:nil textColor:[UIColor cyanColor] font:[UIFont boldSystemFontOfSize:15]];
    //这行
    _titleLable.numberOfLines = 0;
    _titleLable.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_titleLable];
}

- (void)refreshUI:(ReadModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLable.text = model.title;
    _autherLable.text = model.author;
    _timeLable.text = model.createtime;
}

- (void)refreshUI:(ReadModel *)model indexPath:(NSIndexPath *)indexPath{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld:%@",(long)indexPath.row + 1,model.title]];
    if (indexPath.row + 1 > 9){
        [string addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 3)];
    }else{
        [string addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 2)];
    }
    _titleLable.attributedText = string;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
