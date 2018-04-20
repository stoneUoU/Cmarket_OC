//
//  STVFactory.h
//  Fishes
//
//  Created by test on 2018/4/20.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface STVFactory : NSObject
//创建UIView
+ (UIView *)createVWithFrame:(CGRect)frame
                            color:(UIColor *)color;

//创建UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment;

//创建UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate;

//创建UITextView
+ (UITextView *)createTextVWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment;

//创建UIButton
+ (UIButton *)createBtnWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               font:(UIFont *)font
                    backgroundImage:(UIImage *)backgroundImage
                             target:(id)target
                             action:(SEL)action;

//创建图片
+ (UIImageView*) createImageVWithFrame:(CGRect)frame
                                    image:(UIImage*)image;


@end
