//
//  ValidatedFile.m
//  Fishes
//
//  Created by test on 2018/3/28.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "ValidatedFile.h"

@implementation ValidatedFile
//手机号
+ (BOOL) MobileIsValidated:(NSString *)str
{
    NSString *phoneCheck=@"1[345789]([0-9]){9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneCheck];
    return  [phoneTest evaluateWithObject:str];
}
//邮箱
+ (BOOL) EmailIsValidated:(NSString *)str
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:str];
}
//身份证
+ (BOOL) IdCardIsValidated:(NSString *)str
{
    if (str.length <= 0) {
        return NO;
    }
    NSString *idCardCheck = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idCardCheck];
    return [idCardTest evaluateWithObject:str];
}
//登录密码
+ (BOOL) LoginCodeIsValidated:(NSString *)str
{
    NSString *loginCodeCheck = @"^\\w{6,15}$";
    NSPredicate *loginCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",loginCodeCheck];
    return [loginCodeTest evaluateWithObject:str];
}
//支付密码
+ (BOOL) PayCodeIsValidated:(NSString *)str{
    NSString *payCodeCheck = @"^\\d{6}$";
    NSPredicate *payCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",payCodeCheck];
    return [payCodeTest evaluateWithObject:str];
}
//银行卡密码
+ (BOOL) BankCardIsValidated:(NSString *)str{
    NSString *bankCardCheck = @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)";
    NSPredicate *bankCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",bankCardCheck];
    return [bankCardTest evaluateWithObject:str];
}

@end
