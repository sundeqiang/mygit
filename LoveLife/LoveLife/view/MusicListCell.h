//
//  MusicListCell.h
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class musicModel;
@interface MusicListCell : UITableViewCell
{
    UIImageView *_imageView;
    //演唱者
    UILabel *_auther;
    //歌曲名
    UILabel *_nameLable;

}
-(void) refreshUI:(musicModel *)model;

@end
