//
//  HomeDetailMs.h
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface HomeDetailMs : NSObject
@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString* discount_price;
@property (nonatomic, copy) NSString* volume;
@property (nonatomic, copy) NSString* vendor_id;
@property (nonatomic, copy) NSString* freeze_inventory;
@property (nonatomic, copy) NSString* vendor;
@property (nonatomic, copy) NSString* logistics_fee;

@property (nonatomic, copy) NSString* small_pic;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* total_inventory;
@property (nonatomic, copy) NSString* qty;
@property (nonatomic, copy) NSString* vendor_avatar;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* turnover;
@property (nonatomic, copy) NSString* detail;
@property (nonatomic, copy) NSString* start_time;

@property (nonatomic, copy) NSString* end_time;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* category_id;
@property (nonatomic, copy) NSString* actual_logistics_fee;
@property (nonatomic, copy) NSString* desc;

@property NSMutableArray* banner_list;
@property NSMutableArray* attr_value_list;
@end

@interface HomeDetailSonMs : NSObject

@property (nonatomic, copy) NSString* attr_value;
@property (nonatomic, copy) NSString* attr_name;
@property (nonatomic, copy) NSString* attr_type;

@end





