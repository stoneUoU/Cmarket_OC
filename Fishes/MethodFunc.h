//
//  MethodFunc.h
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodFunc : NSObject
//present普通视图
+ (void)presentToCommVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC;

//present导航栏视图
+ (void)presentToNaviVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC;

//dissmiss 被present的视图
+ (void)dismissCurrVC:(UIViewController *)selfVC;

//push导航栏视图
+ (void)pushToNextVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC;

//pop到前一个视图
+ (void)popToPrevVC:(UIViewController *)selfVC;

//pop到特定的视图
//+ (void)popToSpecialVC:(UIViewController *)selfVC specialVC:(Class)specialVC;

//pop到根视图
+ (void)popToRootVC:(UIViewController *)selfVC;

//直接返回到HomeVC
+ (void)backToHomeVC:(UIViewController *)selfVC;

//获取当前屏幕显示的视图
+ (UIViewController *)getCurrVC;

//统一处理登录失效的问题
+ (void)dealAuthMiss:(UIViewController *)selfVC tipInfo:(NSString *)tipInfo;

//设置带有图片的富文本
+ (NSAttributedString *)strWithUIImage:(NSString *) contentStr andImage:(NSString *) imageStr andBounds:(CGRect ) rects;

//设置符号变小的富文本￥0.01
+ (NSAttributedString *)strWithSymbolsS:(NSString *) contentStr andSymbolsC:(UIColor *)symbolsC;
@end
