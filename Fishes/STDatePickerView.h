//
//  STDatePickerView.h
//  Fishes
//
//  Created by test on 2018/4/11.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

// 时间选择View
#import <UIKit/UIKit.h>

@class STDatePickerView;

@protocol STDatePickerViewDelegate <NSObject>

@optional
/**
 返回选择的时间字符串

 @param pickerView pickerView
 @param dateString 时间字符串
 */
- (void)pickerView:(STDatePickerView *)pickerView didSelectDateString:(NSString *)dateString;

@end

@interface STDatePickerView : UIView

@property (nonatomic, weak) id<STDatePickerViewDelegate> delegate;

/**
 初始化STDatePickerView

 @param date 默认时间
 @param mode 时间显示格式
 @return STDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode;

/**
 移除PickerView
 */
- (void)remove;

/**
 显示PickerView
 */
- (void)show;

@end
