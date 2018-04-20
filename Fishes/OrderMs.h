//
//  OrderMs.h
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMs : NSObject
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* pay_time;
@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* shop_name;
@property (nonatomic, copy) NSString* product_type;
@property (nonatomic, copy) NSString* group_title;
@property (nonatomic, copy) NSString* order_no;
@property (nonatomic, copy) NSString* consumer_status;
@property (nonatomic, copy) NSString* create_time;
@property (nonatomic, copy) NSString* product_amount_total;
@property (nonatomic, copy) NSString* pay_type;
@property (nonatomic, copy) NSString* expect_reach_time;
@property (nonatomic, copy) NSString* logistics_fee;
@property (nonatomic, copy) NSString* small_pic;
@property (nonatomic, copy) NSString* addr_id;
@property (nonatomic, copy) NSString* pay_channel;
@property (nonatomic, copy) NSString* order_amount_total;
@property (nonatomic, copy) NSString* product_discount;
@property (nonatomic, copy) NSString* delivery_time;
@property (nonatomic, copy) NSString* product_name;
@property (nonatomic, copy) NSString* ids;
@property (nonatomic, copy) NSString* shop_avatar;
@property (nonatomic, copy) NSString* num;
@property (nonatomic, copy) NSString* product_price;
@property (nonatomic, copy) NSString* take_delivery_period;
@property (nonatomic, copy) NSString* out_trade_no;
@property (nonatomic, copy) NSString* actual_logistics_fee;
@property BOOL is_deleted;
@property NSMutableArray* address;
@property NSMutableArray* refundment;
@end


@interface OrderSonAMs : NSObject
@property (nonatomic, copy) NSString* consignee_name;
@property (nonatomic, copy) NSString* orderlogistics_status;
@property (nonatomic, copy) NSString* logistics_name;
@property (nonatomic, copy) NSString* logistics_code;
@property (nonatomic, copy) NSString* express_no;
@property (nonatomic, copy) NSString* consignee_tel;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* consignee_address;
@property (nonatomic, copy) NSString* logistics_type_id;
@end


@interface OrderSonRMs : NSObject
@property (nonatomic, copy) NSString* actual_refund_amount;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* outrefund_no;
@property (nonatomic, copy) NSString* update_time;
@end

