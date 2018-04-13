//
//  MineMs.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineMs.h"

@implementation MineMs
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ids" : @"id"};
}
- (id)init
{
    _order_num = [NSMutableArray array];
    return [super init];
}
@end

@implementation MineSonMs
@end
