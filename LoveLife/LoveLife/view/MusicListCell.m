//
//  MusicListCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "MusicListCell.h"
#import "musicModel.h"
@implementation MusicListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self creteUI];
    }
    return self;
}

- (void)creteUI{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 100, 70) imageName:nil];
    _nameLable = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 15, 20, 150, 20) text:nil textColor:[UIColor blueColor] font:[UIFont systemFontOfSize:15]];
    _auther = [FactoryUI createLabelWithFrame:CGRectMake(_nameLable.frame.origin.x, _nameLable.frame.size.height + _nameLable.frame.origin.y + 10, 100, 20) text:nil textColor:[UIColor greenColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_nameLable];
    [self.contentView addSubview:_auther];
}

- (void)refreshUI:(musicModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
    _nameLable.text = model.title;
    _auther.text = model.artist;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
