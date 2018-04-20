//
//  STVFactory.m(Stone + View +Factory).m
//  Fishes
//
//  Created by test on 2018/4/20.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "STVFactory.h"

@implementation STVFactory
//创建UIView
+ (UIView *)createVWithFrame:(CGRect)frame
                       color:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
//创建UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame
text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
    return label;
}

//创建UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     font:(UIFont *)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = font;
    textField.secureTextEntry = secureTextEntry;
    textField.delegate = delegate;
    return textField;
}

//创建UITextView
+ (UITextView *)createTextVWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = color;
    textView.textAlignment = textAlignment;

    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;

    return textView;
}

//创建UIButton
+ (UIButton *)createBtnWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               font:(UIFont *)font
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//创建图片
+ (UIImageView*) createImageVWithFrame:(CGRect)frame
                                    image:(UIImage*)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
    return imgView;
}
@end
