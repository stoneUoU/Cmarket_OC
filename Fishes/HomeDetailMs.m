//
//  HomeDetailMs.m
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HomeDetailMs.h"

@implementation HomeDetailMs
- (id)initMs:(NSString *)start_time total_inventory:(NSString *)total_inventory qty:(NSString *)qty group_id:(NSString *)group_id freeze_inventory:(NSString *)freeze_inventory vendor:(NSString *)vendor volume:(NSString *)volume price:(NSString *)price status:(NSString *)status end_time:(NSString *)end_time turnover:(NSString *)turnover discount_price:(NSString *)discount_price detail:(NSString *)detail title:(NSString *)title vendor_id:(NSString *)vendor_id small_pic:(NSString *)small_pic logistics_fee:(NSString *)logistics_fee actual_logistics_fee:(NSString *)actual_logistics_fee type:(NSString *)type subtitle:(NSString *)subtitle vendor_avatar:(NSString *)vendor_avatar category_id:(NSString *)category_id{
    if(self=[super init]){
        self.start_time = start_time;
        self.total_inventory = total_inventory;
        self.qty = qty;
        self.group_id = group_id;
        self.freeze_inventory = freeze_inventory;
        self.vendor = vendor;
        self.volume = volume;
        self.price = price;
        self.status = status;
        self.end_time = end_time;
        self.turnover = turnover;
        self.discount_price = discount_price;
        self.detail = detail;
        self.title = title;
        self.vendor_id = vendor_id;
        self.small_pic = small_pic;
        self.logistics_fee = logistics_fee;
        self.actual_logistics_fee = actual_logistics_fee;
        self.type = type;
        self.subtitle = subtitle;
        self.vendor_avatar = vendor_avatar;
        self.category_id = category_id;
    }
    return self;
}
@end
