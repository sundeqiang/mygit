//
//  FoodDetailModel.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 QF. All rights reserved.
//

#import "FoodDetailModel.h"

@implementation FoodDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"step"]){
        self.dishes_step_desc = value[1][@"dishes_step_desc"];
//        self.dishes_step_image = value[3][@"dishes_step_image"];
//        self.dishes_step_order = value[4][@"dishes_step_order"];
    }
}

@end
