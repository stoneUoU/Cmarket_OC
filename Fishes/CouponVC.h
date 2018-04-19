//
//  CouponVC.h
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
// 优惠券
#import <UIKit/UIKit.h>
#import "CouponV.h"
#import "UIViewController+CBPopup.h"

typedef void(^CouponB)(NSDictionary *, BOOL);

typedef void(^CloseSelfB)(NSDictionary *, BOOL);
@interface CouponVC : UIViewController<CouponVDel>
@property (nonatomic,strong) CouponV *couponV;

@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;
//传categroy_id和总价
@property(nonatomic,strong)NSDictionary *pass_Vals;

@property (nonatomic, strong) CouponMs *selMs;

@property (nonatomic, assign) NSString *selRow;

@property (nonatomic, strong) CouponB couponB;

@property (nonatomic, strong) CloseSelfB closeSelfB;
//row 选中哪一行:
- (id)initWithParams:(NSString*) category_id andTotalO:(NSString*)totalO andRow:(NSString*)selRow;
@end
