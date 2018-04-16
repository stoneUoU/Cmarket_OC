//
//  OrderMs.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderMs.h"

@implementation OrderMs
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ids" : @"id",@"description" : @"desc"};
}
- (id)init
{
    _address = [NSMutableArray array];
    _refundment = [NSMutableArray array];
    return [super init];
}
@end

@implementation OrderSonAMs
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"description" : @"desc"};
}
@end

@implementation OrderSonRMs
@end
