//
//  FirmOrderV.h
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FirmOrderVDel
//这里只需要声明方法
- (void)toDo;
@end
@interface FirmOrderV : UIView

@property (nonatomic, weak) id<FirmOrderVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIButton *doBtn;

@end
