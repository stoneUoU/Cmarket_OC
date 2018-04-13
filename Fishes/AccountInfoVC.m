//
//  AccountInfoVC.m
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "AccountInfoVC.h"

static AccountInfoVC *_shareIns = nil;

@implementation AccountInfoVC
//单例模式
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
    return [AccountInfoVC shareIns] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [AccountInfoVC shareIns] ;
}
- (id)init
{
    _accountInfoV = [[AccountInfoV alloc] init]; //对MyUIView进行初始化
    _accountInfoV.backgroundColor = [UIColor whiteColor];
    _accountInfoV.delegate = self; //将自己的实例作为委托对象

    _arrO = [NSArray arrayWithObjects:@"5",@"林磊",@"oooooo",nil];
    _dictO =  [NSDictionary dictionaryWithObjectsAndKeys:
               @"male", @"sex",
               @"20", @"age",
               @"Tom", @"name",
               @"run",@"hobby", nil ];


//    STLog(@"%@",_arrO[2]);
//    STLog(@"%@",[_arrO objectAtIndex:1]);
//    //字典可以有两种取值方式:
//    STLog(@"%@",_dictO[@"sex"]);
//    STLog(@"%@",[_dictO objectForKey:@"hobby"]);
    //初始化pickerController
    self.pickerController = [[UIImagePickerController alloc]init];
    self.pickerController.view.backgroundColor = [UIColor whiteColor];
    self.pickerController.delegate = self;
    self.pickerController.allowsEditing = YES;

    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"账户信息" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:[UIColor clearColor]];
    [self setUpUI];
    [self startR];
}
- (void)setUpUI{
    [self.view addSubview:_accountInfoV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_accountInfoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}


// MARK: - SetVDel
//- (void)toTest {
//
//}

//发送网络请求：（查询个人信息R）
-(void)startR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/list" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"我进这请求了哈  %@",feedBacks);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [self.accountInfoV.accountInfoMs removeAllObjects];
                self.accountInfoV.accountInfoMs = [NSMutableArray arrayWithArray:@[
                @[
                    @{@"modelName":@"头像",@"vals":[NSURL URLWithString:[picUrl stringByAppendingString: feedBacks[@"data"][@"avatar"]]]}
                    ],
                @[
                    @{@"modelName":@"账户安全",@"vals":@""}
                    ],
                @[
                    @{@"modelName":@"昵称",@"vals":feedBacks[@"data"][@"nick_name"]},
                    @{@"modelName":@"性别",@"vals":[feedBacks[@"data"][@"gender"]  isEqual: @"0"] ? @"女" : @"男"},
                    @{@"modelName":@"生日",@"vals":feedBacks[@"data"][@"birthday"]}
                    ]
                ]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.accountInfoV.tableV reloadData];
                });
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}


-(void)modifyR:(NSDictionary *)dict deal:(NSInteger)deal{
    //STLog(@"%@",dict);
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/info/modify" withParaments:dict Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                if (deal == 0){
                    [HudTips showToast:@"上传成功" showType:Pos animationType:StToastAnimationTypeScale];
                    if (_nickB != NULL){
                        _nickB(@{@"postN":@"上传头像成功"}, YES);
                    }
                }else{
                    [HudTips showToast:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                    if (deal == 1){
                        if (_nickB != NULL){
                            _nickB(@{@"postN":@"昵称修改成功"}, YES);
                        }
                    }
                }
                [self startR];
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}

// MARK: -  AccountInfoVDel
-(void) toGo:(NSInteger)section row:(NSInteger)row{
    if (section == 0 && row == 0){
        [self selPhoto];
    }else if(section == 2 && row == 0){
        [self modifyR:@{@"nick_name":@"不屑的小坦克"} deal:1];
    }else if(section == 2 && row == 1){
        [self setSex];
    }else if(section == 2 && row == 2){
        STDatePickerView *pickerView = [[STDatePickerView alloc] initDatePickerWithDefaultDate:nil
                                                                             andDatePickerMode:UIDatePickerModeDate];
        pickerView.delegate = self;
        [pickerView show];
    }
}
// MARK: -  STDatePickerViewDel
- (void)pickerView:(STDatePickerView *)pickerView didSelectDateString:(NSString *)dateString
{
    [self modifyR:@{@"birthday":dateString} deal:2];
}
-(void) setSex{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.1 创建按钮
    UIAlertAction *maleBtn = [UIAlertAction actionWithTitle:@"男性" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self modifyR:@{@"gender":@"1"} deal:2];
    }];
    UIAlertAction *femaleBtn = [UIAlertAction actionWithTitle:@"女性" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self modifyR:@{@"gender":@"0"} deal:2];
    }];
    UIAlertAction *failBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    // 2.2 添加按钮
    [alertController addAction:maleBtn];
    [alertController addAction:femaleBtn];
    [alertController addAction:failBtn];
    //显示弹框.(相当于show操作)
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) selPhoto{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.1 创建按钮
    UIAlertAction *photoBtn = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [self makePhoto];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    }];
    UIAlertAction *libBtn = [UIAlertAction actionWithTitle:@"从相册里面选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            [self pictureLibrary];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    }];
    UIAlertAction *failBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    // 2.2 添加按钮
    [alertController addAction:photoBtn];
    [alertController addAction:libBtn];
    [alertController addAction:failBtn];
    //显示弹框.(相当于show操作)
    [self presentViewController:alertController animated:YES completion:nil];
}

//跳转到imagePicker里
- (void)makePhoto
{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.pickerController animated:YES completion:nil];
}
//跳转图库
- (void)pictureLibrary
{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.pickerController animated:YES completion:nil];
}
//用户取消退出picker时候调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"%@",picker);
    [self.pickerController dismissViewControllerAnimated:YES completion:^{

    }];
}
//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *userImage = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    userImage = [self scaleImage:userImage toScale:0.3];
    [self.pickerController dismissViewControllerAnimated:YES completion:^{
    }];
    //照片上传
    [self upDateHeadIcon:userImage];
}
- (void)upDateHeadIcon:(UIImage *)photo
{
    //两种方式上传头像
    /*方式一：使用NSData数据流传图片*/
    [NetWorkManager shareManager].responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置请求头
    [[NetWorkManager shareManager].requestSerializer setValue: self.Auths forHTTPHeaderField:@"Authorization"];
    [NetWorkManager shareManager].responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript", nil];
    ///api/cht/app/v1/
    [[NetWorkManager shareManager] POST:[CMarketUrl stringByAppendingString: @"api/cht/app/v1/upload"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(photo, 1.0) name:@"file" fileName:@"test.jpg" mimeType:@"image/jpg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable  responseObject)  {
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([[NSString stringWithFormat:@"%@",jsonDict[@"code"]]  isEqual: @"0"]){
            [self modifyR:@{@"avatar":jsonDict[@"data"][@"file_url"][0]} deal:0];
        }else{
            [HudTips showToast: jsonDict[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

//缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}
//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {

    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
