//
//  AccountInfoVC.h
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AccountInfoV.h"
#import "STDatePickerView.h"

typedef void(^NickB)(NSDictionary *, BOOL);

@interface AccountInfoVC : BaseToolVC<AccountInfoVDel,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,STDatePickerViewDelegate>
@property (nonatomic,strong) AccountInfoV *accountInfoV;

@property UIImagePickerController *pickerController;

@property (nonatomic, strong) NickB nickB;

@property (nonatomic, strong) NSArray* arrO;

@property (nonatomic, strong) NSDictionary* dictO;
//使用单例并实现闭包
+(instancetype) shareIns;
@end
