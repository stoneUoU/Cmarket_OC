//
//  BaseModel.h
//  Fishes
//
//  Created by test on 2018/4/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

// @property (nonamic,copy)NSString *userName
// 数据字典   key ：user_name



@interface BaseModel : NSObject

/**
 建立映射字典
 { key =  propertyName：value = 字段name(数据字典的key)}
 userName ： user_name

 */


//初始化方法
-(id)initWithDataDic:(NSDictionary*)dataDic;

//属性映射字典
- (NSDictionary*)attributeMapDictionary;

//设置属性
- (void)setAttributes:(NSDictionary*)dataDic;

@end
