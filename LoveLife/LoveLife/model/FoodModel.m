//
//  FoodModel.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 QF. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]){
        self.detail = value;
    }
//    if ([key isEqualToString:@"id"]){
//        self.dataID = value;
//    }
    
}

@end
