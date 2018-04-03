//
//  STPayManager.m
//  Fishes
//
//  Created by test on 2018/3/30.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "STPayManager.h"
// 回调url地址为空
#define STTIP_CALLBACKURL @"url地址不能为空！"
// 订单信息为空字符串或者nil
#define STTIP_ORDERMESSAGE @"订单信息不能为空！"
// 没添加 URL Types
#define STTIP_URLTYPE @"请先在Info.plist 添加 URL Type"
// 添加了 URL Types 但信息不全
#define STTIP_URLTYPE_SCHEME(name) [NSString stringWithFormat:@"请先在Info.plist 的 URL Type 添加 %@ 对应的 URL Scheme",name]
@interface STPayManager ()<WXApiDelegate>
// 缓存回调
@property (nonatomic,copy)STCompleteCallBack callBack;
// 缓存appScheme
@property (nonatomic,strong)NSMutableDictionary *appSchemeDict;
@end

@implementation STPayManager
+ (instancetype)shareManager{
    static STPayManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)st_handleUrl:(NSURL *)url{

    NSAssert(url, STTIP_CALLBACKURL);
    if ([url.host isEqualToString:@"pay"]) {// 微信
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"]) {// 支付宝
        // 支付跳转支付宝钱包进行支付，处理支付结果(在app被杀模式下，通过这个方法获取支付结果）
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSString *errStr = resultDic[@"memo"];
            STErrCode errorCode = STErrCodeSuccess;
            switch (resultStatus.integerValue) {
                case 9000:// 成功
                    errorCode = STErrCodeSuccess;
                    break;
                case 6001:// 取消
                    errorCode = STErrCodeCancel;
                    break;
                default:
                    errorCode = STErrCodeFailure;
                    break;
            }
            if ([STPayManager shareManager].callBack) {
                [STPayManager shareManager].callBack(errorCode,errStr);
            }
        }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }
    else{
        return NO;
    }
}

- (void)st_registerApp{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *urlTypes = dict[@"CFBundleURLTypes"];
    NSAssert(urlTypes, STTIP_URLTYPE);
    for (NSDictionary *urlTypeDict in urlTypes) {
        NSString *urlName = urlTypeDict[@"CFBundleURLName"];
        NSArray *urlSchemes = urlTypeDict[@"CFBundleURLSchemes"];
        NSAssert(urlSchemes.count, STTIP_URLTYPE_SCHEME(urlName));
        // 一般对应只有一个
        NSString *urlScheme = urlSchemes.lastObject;
        if ([urlName isEqualToString:STWECHATURLNAME]) {
            [self.appSchemeDict setValue:urlScheme forKey:STWECHATURLNAME];
            // 注册微信
            [WXApi registerApp:urlScheme];
        }
        else if ([urlName isEqualToString:STALIPAYURLNAME]){
            // 保存支付宝scheme，以便发起支付使用
            [self.appSchemeDict setValue:urlScheme forKey:STALIPAYURLNAME];
        }
        else{

        }
    }
}
- (BOOL)st_orInstall{

    if (![WXApi isWXAppInstalled]) {
        //判断是否有微信
        [HudTips showToast:@"未安装微信" showType:Pos animationType:StToastAnimationTypeScale];
        return NO;
    }else if (![WXApi isWXAppSupportApi]){
        //判断是否有微信
        [HudTips showToast:@"当前版本微信不支持微信支付" showType:Pos animationType:StToastAnimationTypeScale];
        return NO;
    }else{
        return YES;
    }
}
-(PayReq *)st_getWXPayParam:(NSDictionary *)wxDict{
    PayReq* req = [[PayReq alloc] init];
    req.openID = WeChatAppID;
    req.partnerId = WeChatPartnerid;
    req.prepayId= [wxDict objectForKey:@"prepayid"];
    req.package = [wxDict objectForKey:@"package"];
    req.nonceStr= [wxDict objectForKey:@"noncestr"];
    req.timeStamp= (UInt32)[wxDict objectForKey:@"timestamp"] ;
    req.sign= [wxDict objectForKey:@"sign"];
    return req;
}
- (void)st_payWithOrderMessage:(id)orderMessage callBack:(STCompleteCallBack)callBack{
    NSAssert(orderMessage, STTIP_ORDERMESSAGE);
    // 缓存block
    self.callBack = callBack;
    // 发起支付
    if ([orderMessage isKindOfClass:[PayReq class]]) {
        // 微信
        NSAssert(self.appSchemeDict[STWECHATURLNAME], STTIP_URLTYPE_SCHEME(STWECHATURLNAME));

        [WXApi sendReq:(PayReq *)orderMessage];
    }
    else if ([orderMessage isKindOfClass:[NSString class]]){
        // 支付宝
        NSAssert(![orderMessage isEqualToString:@""], STTIP_ORDERMESSAGE);
        NSAssert(self.appSchemeDict[STALIPAYURLNAME], STTIP_URLTYPE_SCHEME(STALIPAYURLNAME));
        [[AlipaySDK defaultService] payOrder:(NSString *)orderMessage fromScheme:self.appSchemeDict[STALIPAYURLNAME] callback:^(NSDictionary *resultDic){
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSString *errStr = resultDic[@"memo"];
            STErrCode errorCode = STErrCodeSuccess;
            switch (resultStatus.integerValue) {
                case 9000:// 成功
                    errorCode = STErrCodeSuccess;
                    break;
                case 6001:// 取消
                    errorCode = STErrCodeCancel;
                    break;
                default:
                    errorCode = STErrCodeFailure;
                    break;
            }
            if ([STPayManager shareManager].callBack) {
                [STPayManager shareManager].callBack(errorCode,errStr);
            }
        }];
    }
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    // 判断支付类型
    if([resp isKindOfClass:[PayResp class]]){
        //支付回调
        STErrCode errorCode = STErrCodeSuccess;
        NSString *errStr = resp.errStr;
        switch (resp.errCode) {
            case 0:
                errorCode = STErrCodeSuccess;
                errStr = @"订单支付成功";
                break;
            case -1:
                errorCode = STErrCodeFailure;
                errStr = resp.errStr;
                break;
            case -2:
                errorCode = STErrCodeCancel;
                errStr = @"用户中途取消";
                break;
            default:
                errorCode = STErrCodeFailure;
                errStr = resp.errStr;
                break;
        }
        if (self.callBack) {
            self.callBack(errorCode,errStr);
        }
    }
}

#pragma mark -- Setter & Getter

- (NSMutableDictionary *)appSchemeDict{
    if (_appSchemeDict == nil) {
        _appSchemeDict = [NSMutableDictionary dictionary];
    }
    return _appSchemeDict;
}

@end

