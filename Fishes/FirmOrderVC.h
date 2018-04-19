//
//  FirmOrderVC.h
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirmOrderV.h"
#import "UIViewController+CBPopup.h"
@interface FirmOrderVC : BaseToolVC<FirmOrderVDel>
@property (nonatomic,strong) FirmOrderV *firmOrderV;

@property(nonatomic,strong)NSDictionary *pass_Vals;

//定义一个弹出视图
@property (assign, nonatomic) CBPopupViewAligment popAligment;
//保存选中的行,在这里用NSString存   为了解决首次打开优惠券时默认选中第一个的bug
@property (nonatomic, assign) NSString* selRow;
@end

