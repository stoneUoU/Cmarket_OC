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
@property (nonatomic, strong) NSString* tag;
@property (nonatomic, strong) NSString* detail;
@property (nonatomic, strong) NSString* defaultA;
@property (nonatomic, strong) NSString* province;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* area;
@property (nonatomic, strong) NSString* addressee;
@property (nonatomic, strong) NSString* tel;
@property (nonatomic, strong) NSString* ids;

@end


//我的优惠券
@interface CouponMs : NSObject
@property (nonatomic, assign) NSInteger discount;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, strong) NSString* begin_time;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* exclude_group;
@property (nonatomic, assign) NSString* coupon_code_id;
@property (nonatomic, strong) NSString* enough_money;
@property (nonatomic, strong) NSString* face_value;
@property (nonatomic, strong) NSString* end_time;
@property (nonatomic, strong) NSString* include_group;
@property (nonatomic, assign) NSInteger coupon_type;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger status;
@end
