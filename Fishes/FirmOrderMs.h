//
//  FirmOrderMs.h
//  Fishes
//
//  Created by test on 2018/4/17.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>
//我的地址
@interface MineAds : NSObject
@property (nonatomic, copy) NSString* tag;
@property (nonatomic, copy) NSString* detail;
@property (nonatomic, copy) NSString* defaultA;
@property (nonatomic, copy) NSString* province;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* area;
@property (nonatomic, copy) NSString* addressee;
@property (nonatomic, copy) NSString* tel;
@property (nonatomic, copy) NSString* ids;

@end


//我的优惠券
@interface CouponMs : NSObject
@property (nonatomic, assign) NSInteger discount;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy) NSString* begin_time;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* exclude_group;
@property (nonatomic, copy) NSString* coupon_code_id;
@property (nonatomic, copy) NSString* enough_money;
@property (nonatomic, copy) NSString* face_value;
@property (nonatomic, copy) NSString* end_time;
@property (nonatomic, copy) NSString* include_group;
@property (nonatomic, assign) NSInteger coupon_type;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger status;
@end
