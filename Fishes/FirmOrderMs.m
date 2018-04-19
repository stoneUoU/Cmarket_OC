//
//  FirmOrderMs.m
//  Fishes
//
//  Created by test on 2018/4/17.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "FirmOrderMs.h"
//我的地址
@implementation MineAds
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"defaultA" : @"default",@"ids" : @"id"};
}
@end


@implementation CouponMs
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}
@end
