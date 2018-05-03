//
//  Macros.h
//  Fishes
//
//  Created by test on 2018/4/20.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>
//自定义Log输入日志+显示行号
#ifdef DEBUG
#define STLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define STLog(...)
#endif
//设计师设计以iphone6为原型：
#define iphoneSixW 375

//以6/6s为准宽度缩小系数
#define StScaleW   [UIScreen mainScreen].bounds.size.width/375.0

//高度缩小系数
#define StScaleH  [UIScreen mainScreen].bounds.size.height/667.0

// UIScreen.
#define  ScreenInfo   [UIScreen mainScreen].bounds.size
// UIScreen width.
#define  ScreenW   [UIScreen mainScreen].bounds.size.width
// UIScreen height.
#define  ScreenH  [UIScreen mainScreen].bounds.size.height
#define  spaceM 15
// iPhone X
#define  isX (ScreenW == 375.f && ScreenH == 812.f ? YES : NO)
// Status bar height.
#define  StatusBarH     (isX ? 44.f : 20.f)
// Navigation bar height.
#define  NavigationBarH  44.f
// Tabbar height.
#define  TabBarH   (isX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  TabbarSafeBottomM        (isX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarH  (isX ? 88.f : 64.f)
#define ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})
//请求地址：生产环境
//#define CMarketUrl  @"https://api.cht.znrmny.com"
//#define picUrl @"https://pic.cht.znrmny.com"
//#define webVIP @"https://webview.cht.znrmny.com/"
//////定义BaseURL后面的一戳
//#define followRoute @"api/cht/app/v1/"

//请求地址：测试环境
#define CMarketUrl  @"http://10.10.0.62:13381/"  //@"https://api.365greenlife.com/"
#define picUrl @"http://10.10.0.62:13380"
#define webVIP @"http://10.10.0.62:13380/"
#define followRoute @""  //@"api/tiptop/v1/"
//定义登录失效的状态码
#define OutCode  @"10009"
//请求超时时间
#define timeoutTime 6.0
//没网时的提示
#define missNetTips @"网络开小差啦，请检查网络"
//登录失效的提示
#define missSsidTips @"登录失效，请重新登录"
//设置弹窗位置
#define Pos StToastShowTypeBottom
//定义颜色（随机）
#define STColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define STRandomC STColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//微信ID
#define WeChatAppID @"wxdfbebafd5dfc1038"
//微信商户号
#define WeChatPartnerid @"1497430442"
//支付宝ID
#define AlipayAppID @"alipay2018011601913586"

//页面风格定制颜色：
#define styleColor  [UIColor color_HexStr:@"af5c3d"]
#define btnSaveColor [UIColor color_HexStr:@"c18e7b"]
#define deepBlackC [UIColor color_HexStr:@"212121"]   //字体颜色
#define midBlackC [UIColor color_HexStr:@"a8a8a8"]   //字体颜色
#define cutOffLineC [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:0.7]//UIColor.RGBA(199, 199, 204,0.70)  //分割线颜色
#define btnDisableC [UIColor color_HexStr:@"d9b7ab"]
#define allBgColor [UIColor color_HexStr:@"f3f3f3"]
#define tagBtnC  [UIColor color_HexStr:@"268339"]
#define labelDisable [UIColor color_HexStr:@"d4d4d4"]  //label置灰
#define progress_barC [UIColor color_HexStr:@"d9b7ab"]  //进度条颜色
#define someTableCellC  [UIColor color_HexStr:@"f9f8f8"]

#define PageMenuH 44
#define HeaderViewH 150


#define defineAuths @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjE1NzE3OTE0NTA1IiwiYWNjb3VudF9pZCI6IjExIn0.t17OALyVnuAAqdHLAQdESsEJ454Qa5PBSiCxc-bjuto"
//极光推送API key
#define jpushAppKey  @"2dc4e49f75398e76bd5df12f"
//用于标识当前应用所使用的APN的证书环境
#define apsForPs  0
#define apsForChannel  @"Publish channel"
//token
//#define authos @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjE1NzE3OTE0NTA1IiwidXNlcl9pZCI6IjEwMDA3Iiwicm9sZV9uYW1lIjoidXNlciIsImV4cCI6MTUyNDEwNjMyMS40MjI1NzYsImlhdCI6MTUyMTUxNDMyMS40MjI1NzYsInR5cGUiOiIzIn0.HwSkoZcSrbPLy4eSPLRIkGNqjM9NEOWlyy2ZXBniGjc"


//在xcode打印中: 数组的[]被改成()   json的 : 被改成 =  , 被改成 ;

//注:  NSArray没有removeAllObject方法  
