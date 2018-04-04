//
//  AboutUsVC.h
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

#import "WebViewJavascriptBridge.h"

@interface AboutUsVC : BaseToolVC<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@property (strong, nonatomic) UIProgressView *progressView;

@property WebViewJavascriptBridge* bridge;

@end
