//
//  MineViewC.h
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineV.h"
#import "SetVC.h"
@interface MineVC: UIViewController<MineVDel>
@property (nonatomic,strong) MineV *mineV;
@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;
@end
