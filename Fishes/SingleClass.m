//
//  SingleInsVC.m
//  Fishes
//
//  Created by test on 2018/4/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
//  单例模式
#import "SingleClass.h"

@implementation SingleClass

static SingleClass *_shareIns = nil;

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
    return [SingleClass shareIns] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [SingleClass shareIns] ;
}
@end
