//
//  MonitorVC.m
//  Fishes
//
//  Created by test on 2018/3/28.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MonitorVC.h"

@interface MonitorVC ()<SLWebSocketDelegate>
@end
@implementation MonitorVC
- (id)init
{
    //初始化MonitorV
    _monitorV = [[MonitorV alloc] init]; //对_monitorV进行初始化
    _monitorV.delegate = self; //将MonitorVC自己的实例作为委托对象

    //初始化接受数据的NSData变量
    _data = [[NSMutableData alloc] init];
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self startR];
    [self setSocket];
}
-(void) setUpUI{
    [self.view addSubview:_monitorV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_monitorV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}
#pragma mark - 连接websocket
-(void) setSocket{
    _socketNet = [WebSocketNetwork shareInstance];
    _socketNet.delegate = self;
    [_socketNet startConnect];
}

//MARK: NSURLSession代码段
-(void) startR{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.1:8080/?action=stream"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.networkServiceType = NSURLNetworkServiceTypeDefault;
    //设置请求超时时间
    config.timeoutIntervalForRequest = 15;
    config.allowsCellularAccess = YES;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //创建网络任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
    //5 发起网络任务
    [task resume];
}
//已经接受到响应头
-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask
didReceiveResponse:(nonnull NSURLResponse *)response
completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSData *data = [NSData dataWithData:self.data];
    self.img = [[UIImage alloc]initWithData:data];
    _monitorV.monitorIV.image = self.img;
    [self.data setLength:0];
    completionHandler(NSURLSessionResponseAllow);
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.data appendData:data];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - MonitorVDel
- (void)toUp {

    NSString *str = @"发送前进指令";
    NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:str,@"desc", nil];
    [_socketNet sendMessage:message];
}
 - (void)toDown {
     NSString *str = @"发送后退指令";
     NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:str,@"desc", nil];
     [_socketNet sendMessage:message];
 }

 - (void)toLeft {
     NSString *str = @"发送左转指令";
     NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:str,@"desc", nil];
     [_socketNet sendMessage:message];
 }

 - (void)toRight {
     NSString *str = @"发送右转指令";
     NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:str,@"desc", nil];
     [_socketNet sendMessage:message];
 }

///--------------------------------------
#pragma mark - SLWebSocketDelegate
///--------------------------------------

-(void)webSocketDidReceivedMessage:(id)message{

    [HudTips showToast: message showType:Pos animationType:StToastAnimationTypeScale];
}

- (void)onLogin:(WebSocketStatus)state
{
    if (state == WebSocketStatusConnected) {
        STLog(@"已登录丫");
    }else{
        STLog(@"未登录丫");
    }
}
@end
