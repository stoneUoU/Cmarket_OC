//
//  SmsLoginV.h
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SmsLoginVDel
//这里只需要声明方法
- (void)toSubmit:(NSString *)tel withSmsCode:(NSString *)smsCode;

- (void)toSmsCode;

- (void)toCodeVC;
@end
@interface SmsLoginV : UIView

@property (nonatomic, weak) id<SmsLoginVDel> delegate; //定义一个属性，可以用来进行get set操作
@property (nonatomic, strong) UIButton *smsBtn;

@property (nonatomic, strong) UITextField *telField;

@property (nonatomic, strong) UITextField *smsField;
@end
