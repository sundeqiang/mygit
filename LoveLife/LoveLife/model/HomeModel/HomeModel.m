//
//  HomeModel.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]){
         self.dataID = value;
    }
}

@end
