//
//  BaseVC.h
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseToolVC : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UICKeyChainStore *keychainStore;

@property (nonatomic ,strong)UIView *statusV;

@property (nonatomic ,strong)UIView *navBarV;

@property (nonatomic ,strong)UILabel *midFontL;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UIButton *sideBtn;
@property (nonatomic ,strong)UIView *cutOffV;

@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;

//创建导航栏
- (void)setUp:(NSString *) midVal sideVal:(NSString *)sideVal backIvName:(NSString *)backIvName navC:(UIColor *)navC midFontC:(UIColor *)midFontC sideFontC:(UIColor *)sideFontC;

//定义方法
-(void) toBack;

//定义方法
-(void) toSide;
@end
