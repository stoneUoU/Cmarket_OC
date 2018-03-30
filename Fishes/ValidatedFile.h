//
//  ValidatedFile.h
//  Fishes
//
//  Created by test on 2018/3/28.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatedFile : NSObject

+ (BOOL) MobileIsValidated:(NSString *)str;

+ (BOOL) EmailIsValidated:(NSString *)str;

+ (BOOL) IdCardIsValidated:(NSString *)str;

+ (BOOL) LoginCodeIsValidated:(NSString *)str;

+ (BOOL) PayCodeIsValidated:(NSString *)str;

+ (BOOL) BankCardIsValidated:(NSString *)str;
@end
