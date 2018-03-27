//
//  AccountInfoV.h
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol AccountInfoVDel
//这里只需要声明方法
- (void)toTest;
@end
@interface AccountInfoV : UIView{
    id<AccountInfoVDel> _delegate; //这个定义会在后面的解释，它是一个协议，用来实现委托。
}
@property id<AccountInfoVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIButton *testBtn;


@end
