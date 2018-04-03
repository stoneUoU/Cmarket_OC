//
//  CarouselMs.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CarouselMs.h"
@implementation CarouselMs
@synthesize banner = _banner;
//实现构造方法
-(id)initMs:(NSString *)banner enable:(NSString *)enable ids:(NSString *)ids params:(NSString *)params sn:(NSString *)sn status:(NSString *)status title:(NSString *)title type:(NSString *)type{
    if(self=[super init]){
        self.banner = banner;
        self.enable = enable;
        self.ids = ids;
        self.params = params;
        self.sn = sn;
        self.status = status;
        self.title = title;
        self.type = type;
    }
    return self;
}

@end

@implementation MoveMs
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ids" : @"id"};
}
@end
