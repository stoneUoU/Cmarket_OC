//
//  AppUpdate.m
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//


#import "AppUpdate.h"
#import "AppUpdateV.h"
@interface AppUpdate ()<AppUpdateVDelegate>

/** 升级提示 */
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic , copy) NSString *currentVersion;//当前app的版本
@property (nonatomic , copy) NSString *lastVersion;//App Store上的版本
@property (nonatomic, copy) NSString *trackViewUrl;//https://itunes.apple.com/us/app/%E5%A5%BD%E4%BF%AE%E5%85%BB/id947218515?mt=8&uo=4
@property (nonatomic, copy) NSString *APP_ID;

//可以自定义提醒View，跟着需求走
@property (nonatomic, strong)AppUpdateV *appUpdateV;
@end

@implementation AppUpdate

//生成单例
static AppUpdate *_shareIns = nil;

+(instancetype) shareIns
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _shareIns = [[super allocWithZone:NULL] init] ;
    }) ;

    return _shareIns ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [AppUpdate shareIns] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [AppUpdate shareIns] ;
}

/**
 检查版本
 */
- (void)appVersion {
    _appUpdateV = [[AppUpdateV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH ) isForcedUpdate:NO versionStr:@"000000"];
    _appUpdateV.delegate = (id)self;
    //有用navigationbar和tabbar的需要加在window上
    [[UIApplication sharedApplication].keyWindow addSubview:_appUpdateV];
    self.appUpdateV.hidden = NO;
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    // app版本
//    self.currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *bundleId = infoDictionary[@"CFBundleIdentifier"];
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@",bundleId]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
//    [request setHTTPMethod:@"POST"];
//    NSURLSession *session = [NSURLSession sharedSession];
//    __weak typeof (self) weakSelf = self;
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (data) {
//            NSError *err;
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
//            NSLog(@"%@\n%@",dict.description,[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//            NSArray *dateArr = dict[@"results"];
//            if (dateArr && dateArr.count) {
//
//                //appStore里面的版本号
//                NSDictionary *releaseInfo = [dateArr objectAtIndex:0];
//                weakSelf.APP_ID = [[releaseInfo objectForKey:@"trackId"] stringValue];
//                weakSelf.trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
//                weakSelf.lastVersion = [releaseInfo objectForKey:@"version"];
//                //当前版本小于AppStore的版本  比如1.2.1<1.2.2 提示更新
//                if ([weakSelf version:weakSelf.currentVersion lessthan:weakSelf.lastVersion]) {
//                    weakSelf.releaseNotes =  [releaseInfo objectForKey:@"releaseNotes"]?:@"1.修复已知bug\n2.优化app性能";
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //弹出升级提示
//                        []
//                        //[weakSelf showUpdateView];
//                    });
//
//                }
//            }
//        }
//
//    }];
//    //开始请求
//    [task resume];
}

//比较数字相关字符串  1.0.1  和 1.0.2
- (BOOL)version:(NSString *)oldver lessthan:(NSString *)newver //系统api
{
    if ([oldver compare:newver options:NSNumericSearch] == NSOrderedAscending)
    {
        return YES;
    }
    return NO;
}
#pragma mark - AppUpdateVDelegate
- (void)toCancel {
    STLog(@"取消");
    self.appUpdateV.hidden = YES;
}

- (void)toAppStore {
    STLog(@"去更新");
}
//- (void)goToAppStoreUpdate
//{
//    NSString *urlStr = [self getAppStroeUrlForiPhone];
//#ifdef __IPHONE_10_0
//    NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:options completionHandler:^(BOOL success) {
//
//    }];
//#else
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//#endif
//
//    [self.updateView dismiss];
//    _updateView = nil;
//}
//
//-(NSString *)getAppStroeUrlForiPhone{
//    return [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@",self.APP_ID];
//}

@end
