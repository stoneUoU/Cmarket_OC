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
@interface StartV : UIView

@property (nonatomic, weak) id<StartVDel> delegate; //定义一个属性，可以用来进行get set操作

@end
