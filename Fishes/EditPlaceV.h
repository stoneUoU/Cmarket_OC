//
//  EditPlaceV.h
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol EditPlaceVDel
//这里只需要声明方法
- (void)toSubmit;
@end
@interface EditPlaceV : UIView

@property (nonatomic, weak) id<EditPlaceVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIButton *exitBtn;


@end
