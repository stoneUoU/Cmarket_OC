//
//  AccountInfoVC.h
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AccountInfoV.h"
@interface AccountInfoVC : BaseToolVC<AccountInfoVDel>
@property (nonatomic,strong) AccountInfoV *accountInfoV;
@end
