//
//  RecordModel.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"image_urls"])
    {
        self.image_url = value[0][@"large"];
    }
}

@end
