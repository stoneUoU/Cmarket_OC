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
@property (nonatomic, strong)NSString *start_time;
//总量
@property (nonatomic, strong)NSString *total_inventory;
//库存
@property (nonatomic, strong)NSString *qty;
//组ID
@property (nonatomic, strong)NSString *group_id;
//已抢多少件
@property (nonatomic, strong)NSString *freeze_inventory;
//店铺名称
@property (nonatomic, strong)NSString *vendor;
//总销量
@property (nonatomic, strong)NSString *volume;
//商品价格
@property (nonatomic, strong)NSString *price;
//状态
@property (nonatomic, strong)NSString *status;
//结束时间
@property (nonatomic, strong)NSString *end_time;
//总销售额
@property (nonatomic, strong)NSString *turnover;
//折后价
@property (nonatomic, strong)NSString *discount_price;
//富文本详情
@property (nonatomic, strong)NSString *detail;
//商品标题
@property (nonatomic, strong)NSString *title;
//商家id
@property (nonatomic, strong)NSString *vendor_id;
//图片路径
@property (nonatomic, strong)NSString *small_pic;
//物流费
@property (nonatomic, strong)NSString *logistics_fee;
//实际物流费
@property (nonatomic, strong)NSString *actual_logistics_fee;
//0代表默认值（普通蔬菜）1代表（绿色蔬菜）2代表（有机蔬菜）3代表（无公害蔬菜）
@property (nonatomic, strong)NSString *type;
//子标题
@property (nonatomic, strong)NSString *subtitle;
//头像
@property (nonatomic, strong)NSString *vendor_avatar;
//分类id
@property (nonatomic, strong)NSString *category_id;
//属性值
@property (nonatomic, strong)NSString *attr_value;
//构造方法
- (id)initMs:(NSString *)start_time total_inventory:(NSString *)total_inventory qty:(NSString *)qty group_id:(NSString *)group_id freeze_inventory:(NSString *)freeze_inventory vendor:(NSString *)vendor volume:(NSString *)volume price:(NSString *)price status:(NSString *)status end_time:(NSString *)end_time turnover:(NSString *)turnover discount_price:(NSString *)discount_price detail:(NSString *)detail title:(NSString *)title vendor_id:(NSString *)vendor_id small_pic:(NSString *)small_pic logistics_fee:(NSString *)logistics_fee actual_logistics_fee:(NSString *)actual_logistics_fee type:(NSString *)type subtitle:(NSString *)subtitle vendor_avatar:(NSString *)vendor_avatar category_id:(NSString *)category_id attr_value:(NSString *)attr_value;
@end




