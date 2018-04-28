//
//  OnStartVC.h
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeBaseTbVC.h"
#import "HomeTbCells.h"
#import "CountDown.h"

@interface OnStartVC : HomeBaseTbVC<STPlaceholderViewDelegate>
@property (strong, nonatomic)  CountDown *countDown;

@end
