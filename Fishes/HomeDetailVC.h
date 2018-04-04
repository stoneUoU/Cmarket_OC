//
//  HomeDetailVC.h
//  Fishes
//
//  Created by test on 2017/11/29.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailV.h"
@interface HomeDetailVC : UIViewController<UIGestureRecognizerDelegate,HomeDetailVDel,UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) HomeDetailV *homeDetailV;
@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;

@property(nonatomic,strong)NSDictionary *pass_Vals;
@end
