//
//  FirmOrderV.h
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailMs.h"
#import "FirmOrderMs.h"
#import "PPNumberButton.h"
#import "UILabel+Deal.h"
@protocol FirmOrderVDel
//去支付
- (void)toPlaceO;
//去优惠券
- (void)toCoupon;
//去实名
- (void)toRealN;
//去编辑地址
- (void)toEditAs:(MineAds *)datas;
//加减个数
- (void)toPlusDescC:(NSInteger )AC;   //AC为商品数量
@end
@interface FirmOrderV : UIView<UITableViewDelegate,UITableViewDataSource,PPNumberButtonDelegate>

@property (nonatomic, weak) id<FirmOrderVDel> delegate; //定义一个属性，可以用来进行get set操作
//底部View
@property (nonatomic ,strong)UIView *botV;

@property (nonatomic ,strong)UILabel *totalA;
//合计金额
@property (nonatomic ,strong)UILabel *totalFee;
//立即支付
@property (nonatomic ,strong)UIButton *payBtn;

//底部View
@property (nonatomic ,strong)UITableView *tableV;

//支付宝选中Image
@property (nonatomic ,strong)UIImageView *alipayS;

//微信选中Image
@property (nonatomic ,strong)UIImageView *weChatS;
//哪种支付方式
@property (nonatomic ,assign)NSInteger selectM;

//用来存数据
@property NSMutableArray* mineAds;
//定义数据源
@property (nonatomic,retain)HomeDetailMs *homeDetailMs;

@property (nonatomic,strong)PPNumberButton *numBtn;
//数量
@property (nonatomic ,assign)NSInteger AC;

//商品总价
@property (nonatomic ,assign)NSString* totalM;

//选中的优惠券selMs
@property (nonatomic, strong) CouponMs *selMs;


@end
