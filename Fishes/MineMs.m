//
//  MineMs.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineMs.h"

@implementation MineMs
@synthesize nick_name;
@synthesize gender;
@synthesize tel;
@synthesize avatar;
@synthesize birthday;
@synthesize user_name;
@synthesize customer_service_tel;
@synthesize has_pay;
@synthesize no_pay;
@synthesize over;
@synthesize no_delivery;
//实现构造方法
- (id)initMs:(NSString *)nick_name gender:(NSString *)gender tel:(NSString *)tel avatar:(NSString *)avatar birthday:(NSString *)birthday user_name:(NSString *)user_name customer_service_tel:(NSString *)customer_service_tel has_pay:(NSString *)has_pay no_pay:(NSString *)no_pay over:(NSString *)over no_delivery:(NSString *)no_delivery{
    if(self=[super init]){
        self.nick_name = nick_name;
        self.gender = gender;
        self.tel = tel;
        self.avatar = avatar;
        self.birthday = birthday;
        self.user_name = user_name;
        self.customer_service_tel = customer_service_tel;
        self.has_pay = has_pay;
        self.no_pay = no_pay;
        self.over = over;
        self.no_delivery = no_delivery;
    }
    return self;
}
@end
