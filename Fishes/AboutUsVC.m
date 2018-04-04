//
//  AboutUsVC.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AboutUsVC.h"

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"jsBridge交互" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:[UIColor clearColor]];
    [self setUpUI];
}
- (void)setUpUI{

    // 第二步：初始化
    //当前版本号：
    // 加载网络Html页面 请设置允许Http请求  //

    // WKWebView初始化
    // 方法一：（简单的设置）
    _webView = [[WKWebView alloc] init];
    _webView.navigationDelegate = self;
    // 加载请求
//    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"JsBridge" ofType:@"html"];
//    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [_webView loadHTMLString:appHtml baseURL:baseURL];
    NSURL *url = [NSURL URLWithString:@"https://webview.cht.znrmny.com/about?version=1.0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    //JsBridge交互
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];

    //JS调OC的方法
    [_bridge registerHandler:@"JS_Call_ObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"OC被调用后响应:调用成功!");
        STLog(@"SUCCC");
    }];

    //OC调用JS的方法
    [_bridge callHandler:@"OC_Call_JS" data: @{ @"OC调用JS": @"Hi there, JS!" } responseCallback:^(id response) {
        STLog(@"testJavascriptHandler responded: %@", response);
    }];

    // KVO，监听webView属性值得变化(estimatedProgress,title为特定的key)
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

    // UIProgressView初始化
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, 0, ScreenW, 1);
    self.progressView.trackTintColor = [UIColor clearColor]; // 设置进度条的色彩
    self.progressView.progressTintColor = styleColor;
    // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
    [self.progressView setProgress:0.1 animated:YES];
    [_webView addSubview:self.progressView];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH-StatusBarAndNavigationBarH);
    }];
}

#pragma mark - KVO监听
// 第三部：完成监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if ([object isEqual:_webView] && [keyPath isEqualToString:@"estimatedProgress"]) { // 进度条
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) { // 加载完成
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });

        } else { // 加载中
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if ([object isEqual:self.webView] && [keyPath isEqualToString:@"title"]) { // 标题
        self.midFontL.text = self.webView.title;
    } else { // 其他
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc {

    // 最后一步：移除监听
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //STLog(@"开始加载");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //STLog(@"返回内容");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //STLog(@"加载完成");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    //STLog(@"加载失败");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
