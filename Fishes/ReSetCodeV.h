//
//  ReSetCodeV.h
//  Fishes
//
//  Created by test on 2018/4/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "STButton.h"
@protocol ReSetCodeVDel
//这里只需要声明方法
- (void)toSubmit:(NSString *)tel withSmsCode:(NSString *)smsCode withCodeCode:(NSString *)codeCode;
//获取验证码
- (void)toSmsCode:(NSString *)tel;
//查看密码
- (void)toSeeCode;
@end
@interface ReSetCodeV : UIView

@property (nonatomic, weak) id<ReSetCodeVDel> delegate; //定义一个属性，可以用来进行get set操作
@property (nonatomic, strong) UIButton *smsBtn;

@property (nonatomic, strong) UITextField *telField;

@property (nonatomic, strong) UITextField *smsField;

@property (nonatomic, strong) UITextField *codeField;

@property (nonatomic, strong) STButton *seeCodeV;

@property (nonatomic, strong) UIButton *submitBtn;
@end
