//
//  HomeDetailMs.h
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface HomeDetailMs : NSObject
@property (nonatomic, strong) NSString* group_id;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString* discount_price;
@property (nonatomic, strong) NSString* volume;
@property (nonatomic, strong) NSString* vendor_id;
@property (nonatomic, strong) NSString* freeze_inventory;
@property (nonatomic, strong) NSString* vendor;
@property (nonatomic, strong) NSString* logistics_fee;

@property (nonatomic, strong) NSString* small_pic;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, assign) NSString* total_inventory;
@property (nonatomic, strong) NSString* qty;
@property (nonatomic, strong) NSString* vendor_avatar;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSString* turnover;
@property (nonatomic, strong) NSString* detail;
@property (nonatomic, strong) NSString* start_time;

@property (nonatomic, strong) NSString* end_time;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* category_id;
@property (nonatomic, strong) NSString* actual_logistics_fee;
@property (nonatomic, strong) NSString* desc;

@property NSMutableArray* banner_list;
@property NSMutableArray* attr_value_list;
@end

@interface HomeDetailSonMs : NSObject

@property (nonatomic, strong) NSString* attr_value;
@property (nonatomic, strong) NSString* attr_name;
@property (nonatomic, strong) NSString* attr_type;

@end





