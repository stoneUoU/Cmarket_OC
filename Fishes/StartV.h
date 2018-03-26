//
//  StartV.h
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StartVDel
//这里只需要声明方法
- (void)toBack;
- (void)toLogin;
- (void)toRegister;
@end
@interface StartV : UIView{
    id<StartVDel> _delegate; //这个定义会在后面的解释，它是一个协议，用来实现委托。
}
@property id<StartVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIView *statusV;

@property (nonatomic ,strong)UIView *navBarV;

@property (nonatomic ,strong)UIButton *backBtn;

@property (nonatomic ,strong)UIImageView *logoIV;

@property (nonatomic ,strong)UIImageView *caiIV;

@property (nonatomic ,strong)UIButton *loginBtn;

@property (nonatomic ,strong)UIButton *registerBtn;

@end
