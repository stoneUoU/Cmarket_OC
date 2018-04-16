//
//  OrderMs.h
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMs : NSObject
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* pay_time;
@property (nonatomic, strong) NSString* group_id;
@property (nonatomic, strong) NSString* shop_name;
@property (nonatomic, strong) NSString* product_type;
@property (nonatomic, strong) NSString* group_title;
@property (nonatomic, strong) NSString* order_no;
@property (nonatomic, strong) NSString* consumer_status;
@property (nonatomic, strong) NSString* create_time;
@property (nonatomic, strong) NSString* product_amount_total;
@property (nonatomic, strong) NSString* pay_type;
@property (nonatomic, strong) NSString* expect_reach_time;
@property (nonatomic, strong) NSString* logistics_fee;
@property (nonatomic, strong) NSString* small_pic;
@property (nonatomic, strong) NSString* addr_id;
@property (nonatomic, strong) NSString* pay_channel;
@property (nonatomic, strong) NSString* order_amount_total;
@property (nonatomic, strong) NSString* product_discount;
@property (nonatomic, strong) NSString* delivery_time;
@property (nonatomic, strong) NSString* product_name;
@property (nonatomic, strong) NSString* ids;
@property (nonatomic, strong) NSString* shop_avatar;
@property (nonatomic, strong) NSString* num;
@property (nonatomic, strong) NSString* product_price;
@property (nonatomic, strong) NSString* take_delivery_period;
@property (nonatomic, strong) NSString* out_trade_no;
@property (nonatomic, strong) NSString* actual_logistics_fee;
@property BOOL is_deleted;
@property NSMutableArray* address;
@property NSMutableArray* refundment;
@end


@interface OrderSonAMs : NSObject
@property (nonatomic, strong) NSString* consignee_name;
@property (nonatomic, strong) NSString* orderlogistics_status;
@property (nonatomic, strong) NSString* logistics_name;
@property (nonatomic, strong) NSString* logistics_code;
@property (nonatomic, strong) NSString* express_no;
@property (nonatomic, strong) NSString* consignee_tel;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* consignee_address;
@property (nonatomic, strong) NSString* logistics_type_id;
@end


@interface OrderSonRMs : NSObject
@property (nonatomic, strong) NSString* actual_refund_amount;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* outrefund_no;
@property (nonatomic, strong) NSString* update_time;
@end

