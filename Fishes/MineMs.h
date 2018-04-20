//
//  MineMs.h
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

//#import <Foundation/Foundation.h>
//@interface MineMs : NSObject {
//    NSString *nick_name;
//    NSString *gender;
//    NSString *tel;
//    NSString *avatar;
//    NSString *birthday;
//    NSString *user_name;
//    NSString *customer_service_tel;
//    NSString *has_pay;
//    NSString *no_pay;
//    NSString *over;
//    NSString *no_delivery;
//}
//@property (nonatomic, strong)NSString *nick_name;
//@property (nonatomic, strong)NSString *gender;
//@property (nonatomic, strong)NSString *tel;
//@property (nonatomic, strong)NSString *avatar;
//@property (nonatomic, strong)NSString *birthday;
//@property (nonatomic, strong)NSString *user_name;
//@property (nonatomic, strong)NSString *customer_service_tel;
//@property (nonatomic, strong)NSString *has_pay;
//@property (nonatomic, strong)NSString *no_pay;
//@property (nonatomic, strong)NSString *over;
//@property (nonatomic, strong)NSString *no_delivery;
////构造方法
//- (id)initMs:(NSString *)nick_name gender:(NSString *)gender tel:(NSString *)tel avatar:(NSString *)avatar birthday:(NSString *)birthday user_name:(NSString *)user_name customer_service_tel:(NSString *)customer_service_tel has_pay:(NSString *)has_pay no_pay:(NSString *)no_pay over:(NSString *)over no_delivery:(NSString *)no_delivery;
//@end

@interface MineMs : NSObject
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, copy) NSString* birthday;
@property (nonatomic, copy) NSString* customer_service_tel;
@property (nonatomic, copy) NSString* enable;
@property (nonatomic, copy) NSString* gender;
@property (nonatomic, copy) NSString* ids;
@property (nonatomic, copy) NSString* nick_name;
@property (nonatomic, copy) NSString* tel;
@property (nonatomic, copy) NSString* username;
@end

@interface MineSonMs : NSObject

@property (nonatomic, copy) NSString* has_pay;
@property (nonatomic, copy) NSString* no_delivery;
@property (nonatomic, copy) NSString* no_pay;
@property (nonatomic, copy) NSString* over;

@end
