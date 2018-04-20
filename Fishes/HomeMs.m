//
//  HomeMs.m
//  Fishes
//
//  Created by test on 2018/3/22.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HomeMs.h"

@implementation HomeMs
//实现构造方法
- (id)initMs:(NSString *)group_id title:(NSString *)title price:(NSString *)price discount_price:(NSString *)discount_price spic:(NSString *)spic status:(NSString *)status total_inventory:(NSString *)total_inventory freeze_inventory:(NSString *)freeze_inventory start_time:(NSString *)start_time end_time:(NSString *)end_time type:(NSString *)type subtitle:(NSString *)subtitle attr_value:(NSString *)attr_value  desc:(NSString *)desc{
    if(self=[super init]){
        self.group_id = group_id;
        self.title = title;
        self.price = price;
        self.discount_price = discount_price;
        self.spic = spic;
        self.status = status;
        self.total_inventory = total_inventory;
        self.freeze_inventory = freeze_inventory;
        self.start_time = start_time;
        self.end_time = end_time;
        self.type = type;
        self.subtitle = subtitle;
        self.attr_value = attr_value;
        self.desc = desc;
    }
    return self;
}
@end
