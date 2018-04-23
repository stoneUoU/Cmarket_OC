//
//  NSString+FloatPreciseCalculation.m
//  Fishes
//
//  Created by test on 2018/4/20.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "NSString+FloatPreciseCalculation.h"

@implementation NSString (FloatPreciseCalculation)

+ (NSString *)floatOne:(NSString *)floatOne
       calculationType:(CalculationType)calculationType
              floatTwo:(NSString *)floatTwo
{
    NSDecimalNumber *_floatOne = [NSDecimalNumber decimalNumberWithString:floatOne];
    NSDecimalNumber *_floatTwo = [NSDecimalNumber decimalNumberWithString:floatTwo];

    NSDecimalNumber *results = nil;

    switch (calculationType) {
        case 0:
        {
            results = [_floatOne decimalNumberByAdding:_floatTwo];
        }
            break;
        case 1:
        {
            results = [_floatOne decimalNumberBySubtracting:_floatTwo];
        }
            break;
        case 2:
        {
            results = [_floatOne decimalNumberByMultiplyingBy:_floatTwo];
        }
            break;
        case 3:
        {
            results = [_floatOne decimalNumberByDividingBy:_floatTwo];
        }
            break;

        default:
            break;
    }

    return results.stringValue;
}

@end
