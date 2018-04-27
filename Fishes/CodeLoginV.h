//
//  CodeLoginV.h
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STButton.h"

@protocol CodeLoginVDel
//这里只需要声明方法
- (void)toSubmit:(NSString *)tel withCode:(NSString *)code;
- (void)toSmsVC;
- (void)toLeftCode;
- (void)toSeeCode;
@end
@interface CodeLoginV : UIView<UITextFieldDelegate>

@property (nonatomic, weak) id<CodeLoginVDel> delegate; //它是一个协议，用来实现委托

@property (nonatomic, strong) UITextField *telField;

@property (nonatomic, strong) UITextField *codeField;

@property (nonatomic, strong) STButton *seeCodeV;
@end
