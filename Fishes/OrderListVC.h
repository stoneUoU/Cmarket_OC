//
//  OrderListVC.h
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListV.h"
@interface OrderListVC : UIViewController<OrderListVDel>
@property (nonatomic,strong) OrderListV *orderListV;
@property(nonatomic,strong)NSDictionary *pass_Vals;

@property (strong, nonatomic) UICKeyChainStore *keychainStore;

@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;


@property (nonatomic,assign)double pageSize;

@end
