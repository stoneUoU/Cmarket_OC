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
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:str];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:str];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:str];
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    } else {
        return NO;
    }
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
    NSString *loginCodeCheck = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
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
#pragma 正则校验URL
+ (BOOL) URLIsValidated : (NSString *) str{
    NSString *urlCheck = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",urlCheck];
    return [urlTest evaluateWithObject:str];
}
#pragma 正则只能输入数字和字母
+ (BOOL) CNumIsValidated : (NSString *) str{
    NSString *cNumCheck = @"^[A-Za-z0-9]+$";
    NSPredicate *cNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",cNumCheck];
    return [cNumTest evaluateWithObject:str];
}

@end
