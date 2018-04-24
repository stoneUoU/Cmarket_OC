//
//  SetVC.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SetVC.h"
@implementation SetVC
- (id)init
{
    _setV = [[SetV alloc] init]; //对MyUIView进行初始化
    _setV.backgroundColor = [UIColor whiteColor];
    _setV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"设置" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
    self.setV.setMs = [NSMutableArray arrayWithArray:@[
   @[
       @{@"modelName":@"账户安全",@"vals":@""}
       ],
   @[
       @{@"modelName":@"清除缓存",@"vals":[self cacheOfSize]},
       @{@"modelName":@"当前版本",@"vals":[@"V" stringByAppendingString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]}
       ]
   ]];
    //[self startR];
}
- (void)setUpUI{
    [self.view addSubview:_setV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_setV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - SetVDel
- (void)toExit {
    //第一步:创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您是否确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.1 创建按钮
    UIAlertAction *succBtn = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self startR];
    }];
    UIAlertAction *failBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    // 2.2 添加按钮
    [alertController addAction:succBtn];
    [alertController addAction:failBtn];
    //显示弹框.(相当于show操作)
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)tableVClick:(NSInteger)section andRow:(NSInteger)row{
    if (section == 0 && row == 0){
        STLog(@"账户安全");
    }else if (section == 1 && row == 0){
        if ([[self cacheOfSize] isEqual:@"0.00MB"]){
            [HudTips showToast: @"缓存为空" showType:Pos animationType:StToastAnimationTypeScale];
        }else{
            [self setCache];
        }
    }
}

-(void) setCache{
    //第一步:创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您是否确定清空缓存？" preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.1 创建按钮
    UIAlertAction *succBtn = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self clearCaches];
        [HudTips showToast: @"缓存清除成功" showType:Pos animationType:StToastAnimationTypeScale];
        self.setV.setMs = [NSMutableArray arrayWithArray:@[
        @[
           @{@"modelName":@"账户安全",@"vals":@""}
           ],
        @[
           @{@"modelName":@"清除缓存",@"vals":[self cacheOfSize]},
           @{@"modelName":@"当前版本",@"vals":[@"V" stringByAppendingString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]}
           ]
        ]];
        [self.setV.tableV reloadData];
    }];
    UIAlertAction *failBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    // 2.2 添加按钮
    [alertController addAction:succBtn];
    [alertController addAction:failBtn];
    //显示弹框.(相当于show操作)
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)startR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/logout" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [HudTips showToast: @"注销成功" showType:Pos animationType:StToastAnimationTypeScale];
                //清空用户信息
                [UICKeyChainStore keyChainStore][@"orLogin"] = @"false";
                [UICKeyChainStore keyChainStore][@"authos"] = @"";
                [MethodFunc backToHomeVC:self];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        if (self.placeholderV == nil){
            self.placeholderV = [[STPlaceholderView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarH, ScreenW, ScreenH - StatusBarAndNavigationBarH ) type:STPlaceholderViewTypeNoNetwork delegate:self];
            [self.view addSubview:self.placeholderV];
        }
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}

// 计算目录大小
- (NSString *)cacheOfSize
{
     //定义变量存储总的缓存大小
     long long sumSize = 0;
     //01.获取当前图片缓存路径
     NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
     //02.创建文件管理对象
     NSFileManager *filemanager = [NSFileManager defaultManager];
     //获取当前缓存路径下的所有子路径
     NSArray *subPaths = [filemanager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
     //遍历所有子文件
     for (NSString *subPath in subPaths) {
                 //1）.拼接完整路径
            NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
                 //2）.计算文件的大小
            long long fileSize = [[filemanager attributesOfItemAtPath:filePath error:nil]fileSize];
                 //3）.加载到文件的大小
            sumSize += fileSize;
      }
     float size_m = sumSize/(1000*1000);
     return [NSString stringWithFormat:@"%.2fMB",size_m];
}
// 根据路径删除文件
- (void)clearCaches{
    // 利用NSFileManager实现对文件的管理
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        STLog(@"清除成功");
    }];
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
