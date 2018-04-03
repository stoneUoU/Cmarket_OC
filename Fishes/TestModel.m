//
//  TestModel.m
//  Fishes
//
//  Created by test on 2018/4/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

@end


@implementation ExpressMs
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"accept_time" : @"AcceptTime",@"accept_station" : @"AcceptStation"};
}
@end
