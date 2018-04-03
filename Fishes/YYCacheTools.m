//
//  YYCacheTools.m
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "YYCacheTools.h"
#import "YYCache.h"
static NSString *const resCache = @"resCache";
static YYCache *_dataCache;
@implementation YYCacheTools
+ (void)initialize {
    _dataCache = [YYCache cacheWithName:resCache];
}
+ (void)setResCache:(id)httpData url:(NSString *)url{
    NSString *cacheKey = url;
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}
//取缓存
+ (id)resCacheForURL:(NSString *)url {
    NSString *cacheKey = url;
    return [_dataCache objectForKey:cacheKey];
}
//判断缓存是否存在
+ (BOOL)isCacheExist:(NSString *)url{
    BOOL isContains=[_dataCache containsObjectForKey:url];
    return isContains;
}
+ (NSInteger)getAllResCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllResCache {
    [_dataCache.diskCache removeAllObjects];
}

@end
