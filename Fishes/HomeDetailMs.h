//
//  HomeDetailMs.h
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface HomeDetailMs : NSObject
//开始时间
@property (nonatomic, assign)NSString *start_time;
//总量
@property (nonatomic, assign)NSString *total_inventory;
//库存
@property (nonatomic, assign)NSString *qty;
//组ID
@property (nonatomic, assign)NSString *group_id;
//已抢多少件
@property (nonatomic, assign)NSString *freeze_inventory;
//店铺名称
@property (nonatomic, assign)NSString *vendor;
//总销量
@property (nonatomic, assign)NSString *volume;
//商品价格
@property (nonatomic, assign)NSString *price;
//状态
@property (nonatomic, assign)NSString *status;
//结束时间
@property (nonatomic, assign)NSString *end_time;
//总销售额
@property (nonatomic, assign)NSString *turnover;
//折后价
@property (nonatomic, assign)NSString *discount_price;
//富文本详情
@property (nonatomic, assign)NSString *detail;
//商品标题
@property (nonatomic, assign)NSString *title;
//商家id
@property (nonatomic, assign)NSString *vendor_id;
//图片路径
@property (nonatomic, assign)NSString *small_pic;
//物流费
@property (nonatomic, assign)NSString *logistics_fee;
//实际物流费
@property (nonatomic, assign)NSString *actual_logistics_fee;
//0代表默认值（普通蔬菜）1代表（绿色蔬菜）2代表（有机蔬菜）3代表（无公害蔬菜）
@property (nonatomic, assign)NSString *type;
//子标题
@property (nonatomic, assign)NSString *subtitle;
//头像
@property (nonatomic, assign)NSString *vendor_avatar;
//分类id
@property (nonatomic, assign)NSString *category_id;
//构造方法
- (id)initMs:(NSString *)start_time total_inventory:(NSString *)total_inventory qty:(NSString *)qty group_id:(NSString *)group_id freeze_inventory:(NSString *)freeze_inventory vendor:(NSString *)vendor volume:(NSString *)volume price:(NSString *)price status:(NSString *)status end_time:(NSString *)end_time turnover:(NSString *)turnover discount_price:(NSString *)discount_price detail:(NSString *)detail title:(NSString *)title vendor_id:(NSString *)vendor_id small_pic:(NSString *)small_pic logistics_fee:(NSString *)logistics_fee actual_logistics_fee:(NSString *)actual_logistics_fee type:(NSString *)type subtitle:(NSString *)subtitle vendor_avatar:(NSString *)vendor_avatar category_id:(NSString *)category_id;
@end




