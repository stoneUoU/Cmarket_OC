//
//  MonitorV.h
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol MonitorVDel
//这里只需要声明方法
- (void)toUp;
- (void)toDown;
- (void)toLeft;
- (void)toRight;
@end
@interface MonitorV : UIView

@property (nonatomic, weak) id<MonitorVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIImageView *monitorIV;

@property (nonatomic ,strong)UIView *dealV;

@property (nonatomic ,strong)UIButton *upV;

@property (nonatomic ,strong)UIButton *downV;

@property (nonatomic ,strong)UIButton *leftV;

@property (nonatomic ,strong)UIButton *rightV;

@property (nonatomic, strong)NSTimer *upTimer;

@property (nonatomic, strong)NSTimer *downTimer;

@property (nonatomic, strong)NSTimer *leftTimer;

@property (nonatomic, strong)NSTimer *rightTimer;

@end
