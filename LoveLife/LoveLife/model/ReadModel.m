//
//  ReadModel.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel
//对于没有定义的过滤掉 
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]){
        self.dataID = value;
    }
}

@end
