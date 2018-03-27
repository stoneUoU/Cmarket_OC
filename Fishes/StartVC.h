//
//  StartVC.h
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartV.h"
@interface StartVC : UIViewController<StartVDel>
@property (nonatomic,strong) StartV *startV;
//从上一个界面传过来的字典：   //定一个值：登录失效是:status_code:0   在主页消息、主页立即购买、商品详情界面登录:status_code:1  进app直接点我的tab登录:status_code:2
@property(nonatomic,strong)NSDictionary *pass_Vals;
@end
