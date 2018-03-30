//
//  STPayManager.h
//  Fishes
//
//  Created by test on 2018/3/30.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
//   App支付

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
/**
 *  @author DevelopmentEngineer-ST
 *
 *  此处必须保证在Info.plist 中的 URL Types 的 Identifier 对应一致
 */
#define STWECHATURLNAME @"weixin"
#define STALIPAYURLNAME @"zhifubao"

#define STPAYMANAGER [STPayManager shareManager]
/**
 *  @author DevelopmentEngineer-ST
 *
 *  回调状态码
 */
typedef NS_ENUM(NSInteger,STErrCode){
    STErrCodeSuccess,// 成功
    STErrCodeFailure,// 失败
    STErrCodeCancel// 取消
};

typedef void(^STCompleteCallBack)(STErrCode errCode,NSString *errStr);
@interface STPayManager : NSObject
/**
 *  @author DevelopmentEngineer-ST
 *
 *  单例管理
 */
+ (instancetype)shareManager;
/**
 *  @author DevelopmentEngineer-ST
 *
 *  处理跳转url，回到应用，需要在delegate中实现
 */
- (BOOL)st_handleUrl:(NSURL *)url;
/**
 *  @author DevelopmentEngineer-ST
 *
 *  注册App，需要在 didFinishLaunchingWithOptions 中调用
 */
- (void)st_registerApp;

//构建微信支付参数
- (PayReq *)st_getWXPayParam:(NSDictionary *)wxDict;

//判断手机中是否安装微信
- (BOOL)st_orInstall:(UIViewController *)selfVC;
/**
 *  @author DevelopmentEngineer-ST
 *
 *  发起支付
 *
 * @param orderMessage 传入订单信息,如果是字符串，则对应是跳转支付宝支付；如果传入PayReq 对象，这跳转微信支付,注意，不能传入空字符串或者nil
 * @param callBack     回调，有返回状态信息
 */
- (void)st_payWithOrderMessage:(id)orderMessage callBack:(STCompleteCallBack)callBack;
@end

