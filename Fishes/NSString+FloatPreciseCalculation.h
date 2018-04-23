//
//  NSString+FloatPreciseCalculation.h
//  Fishes
//
//  Created by test on 2018/4/20.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CalculationType) {

    CalculationTypeForAdd,        //加
    CalculationTypeForSubtract,   //减
    CalculationTypeForMultiply,   //乘
    CalculationTypeForDivide,     //除
};

@interface NSString (FloatPreciseCalculation)

+ (NSString *)floatOne:(NSString *)floatOne
       calculationType:(CalculationType)calculationType
              floatTwo:(NSString *)floatTwo;

@end
