//
//  RegisterVC.h
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterV.h"
@interface RegisterVC : BaseToolVC<RegisterVDel>
@property (nonatomic,strong) RegisterV *registerV;

//从上一个界面传过来的字典：   //定一个值：登录失效是:status_code:0
@property(nonatomic,strong)NSDictionary *pass_Vals;
@end
