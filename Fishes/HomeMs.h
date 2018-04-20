//
//  HomeMs.h
//  Fishes
//
//  Created by test on 2018/3/22.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeMs : NSObject
//拼团ID
@property (nonatomic, strong)NSString *group_id;
//商品标题
@property (nonatomic, strong)NSString *title;
//原价
@property (nonatomic, strong)NSString *price;
//折后价
@property (nonatomic, strong)NSString *discount_price;
//图片
@property (nonatomic, strong)NSString *spic;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *total_inventory;
@property (nonatomic, strong)NSString *freeze_inventory;
@property (nonatomic, strong)NSString *start_time;
@property (nonatomic, strong)NSString *end_time;
//0代表默认值（普通蔬菜）1代表（绿色蔬菜）2代表（有机蔬菜）3代表（无公害蔬菜）
@property (nonatomic, strong)NSString *type;
//子标题
@property (nonatomic, strong)NSString *subtitle;
//属性
@property (nonatomic, strong)NSString *attr_value;

@property (nonatomic, strong)NSString *desc;
//构造方法
- (id)initMs:(NSString *)group_id title:(NSString *)title price:(NSString *)price discount_price:(NSString *)discount_price spic:(NSString *)spic status:(NSString *)status total_inventory:(NSString *)total_inventory freeze_inventory:(NSString *)freeze_inventory start_time:(NSString *)start_time end_time:(NSString *)end_time type:(NSString *)type subtitle:(NSString *)subtitle attr_value:(NSString *)attr_value desc:(NSString *)desc;
@end

