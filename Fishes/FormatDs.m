//
//  FormatDs.m
//  Fishes
//
//  Created by test on 2018/3/22.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "FormatDs.h"

@implementation FormatDs
//格式话小数 四舍五入类型
+(NSString *)retainPoint:(NSString *)format floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

    [numberFormatter setPositiveFormat:format];

    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV/100]];
}
//给倒计时加颜色
+(NSMutableAttributedString *)returnAttrStr:(NSString *)Str{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:nil];

    NSArray *numArr = [regex matchesInString:Str options:0 range:NSMakeRange(0, [Str length])];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Str attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:styleColor                          range:NSMakeRange(0,[Str length])];


    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0,[Str length])];

    for (NSTextCheckingResult *attirbute in numArr) {

        [attributedString setAttributes:@{NSForegroundColorAttributeName:styleColor} range:attirbute.range];

    }

    return attributedString;
}
@end


