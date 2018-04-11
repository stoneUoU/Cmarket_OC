//
//  STButton.h
//  Fishes
//
//  Created by test on 2018/4/8.
//  Copyright © 2018年 com.youlu. All rights reserved.
//  扩大按钮的点击区域

#import <UIKit/UIKit.h>

@interface STButton : UIButton

//第一种方法
@property (nonatomic,assign) CGFloat minimumHitTestWidth;
@property (nonatomic,assign) CGFloat minimumHitTestHeight;

//第二种方法
@property (nonatomic,assign) UIEdgeInsets hitTestEdgeInsets;

@end
