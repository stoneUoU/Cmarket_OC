//
//  RegisterV.h
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol RegisterVDel
//这里只需要声明方法
- (void)toSubmit;
@end
@interface RegisterV : UIView

@property (nonatomic, weak) id<RegisterVDel> delegate; //定义一个属性，可以用来进行get set操作

@end
