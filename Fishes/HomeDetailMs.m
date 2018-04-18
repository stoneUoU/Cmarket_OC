//
//  HomeDetailMs.m
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HomeDetailMs.h"

@implementation HomeDetailMs
//@synthesize title;
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}
- (id)init
{
    _banner_list = [[NSMutableArray alloc]init];
    _attr_value_list = [[NSMutableArray alloc]init];
    return [super init];
}
@end


@implementation HomeDetailSonMs

@end

