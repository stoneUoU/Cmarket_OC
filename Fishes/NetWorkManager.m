//
//  NetWorkManager.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager



#pragma mark - shareManager
/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */

+(instancetype)shareManager
{

    static NetWorkManager * manager = nil;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:CMarketUrl]];

    });

    return manager;
}


#pragma mark - 重写initWithBaseURL
/**
 *
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */

-(instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        //可根据具体情况进行设置
        NSAssert(url,@"您需要为您的请求设置baseUrl");
        /**设置相应的缓存策略*/

        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFJSONRequestSerializer serializer];

        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];

        response.removesKeysWithNullValues = YES;

        self.responseSerializer = response;

        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/

        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        //此处做为测试 可根据自己应用设置相应的值
        /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        //[self.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
        /**设置接受的类型*/
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    }

    return self;
}


#pragma mark - 网络请求的类方法---get/post

/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 */

+(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments Authos:(NSString *)Authos withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock
{

    switch (type) {

        case HttpRequestTypeGet:
        {
            //设置请求头
            [[NetWorkManager shareManager].requestSerializer setValue:Authos forHTTPHeaderField:@"token"];
            /**设置请求超时时间*/
            [[NetWorkManager shareManager].requestSerializer setTimeoutInterval:timeoutTime];
            [[NetWorkManager shareManager] GET:urlString parameters:paraments success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                successBlock(responseObject);

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                failureBlock(error);
            }];

            break;
        }

        case HttpRequestTypePost:

        {
            //设置请求头
            [[NetWorkManager shareManager].requestSerializer setValue:Authos forHTTPHeaderField:@"token"];
            /**设置请求超时时间*/
            [[NetWorkManager shareManager].requestSerializer setTimeoutInterval:timeoutTime];
            [[NetWorkManager shareManager] POST:urlString parameters:paraments success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                successBlock(responseObject);

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                failureBlock(error);

            }];
        }

    }

}

#pragma mark -  取消所有的网络请求

/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

+(void)cancelAllRequest
{

    [[NetWorkManager shareManager].operationQueue cancelAllOperations];

}



#pragma mark -   取消指定的url请求/
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
{

    NSError * error;

    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/

    NSString * urlToPeCanced = [[[[NetWorkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];


    for (NSOperation * operation in [NetWorkManager shareManager].operationQueue.operations) {

        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {

            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];

            //请求的url匹配

            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];

            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {

                [operation cancel];

            }
        }

    }
}


@end
