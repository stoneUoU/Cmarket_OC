//
//  ThreadVC.m
//  Fishes
//
//  Created by test on 2018/4/8.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "ThreadVC.h"

#import "CircleView.h"

#import "STButton.h"

@interface ThreadVC ()
@property (nonatomic,strong) CircleView *circleView;

@end

@implementation ThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //[self toSetUp];

    //①获取当前线程
    //NSThread *current = [NSThread currentThread];
    //②获取主线程
    //NSThread *main = [NSThread mainThread];
    //③暂停当前线程
    //[NSThread sleepForTimeInterval:2];
    //④线程之间通信
    //在指定线程上执行操作
    //[self performSelector:@selector(run) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    //在主线程上执行操作
    //[self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:YES];
    //在当前线程执行操作
    //[self performSelector:@selector(run) withObject:nil];

//    CircleView *circleView = [[CircleView alloc]initWithFrame:CGRectMake(200, 200, 150, 150)];
//    self.circleView = circleView;
//    self.circleView.progress = 0.60;
//    [self.view addSubview:circleView];

//    STButton *button = [[STButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    button.hitTestEdgeInsets = UIEdgeInsetsMake(-50, -50, -50, -50);
//    [button setTitle:@"点我呀" forState:UIControlStateNormal];
//    [button setTitle:@"点中了" forState:UIControlStateHighlighted];
//    button.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:button];
    
}

//- (void)pingResult:(NSNumber*)success {
//    if (success.boolValue) {
//        STLog(@"拼得通");
//    } else {
//        STLog(@"拼不通");
//    }
//}

-(void) toSetUp{
    for (int i = 0; i<3 ; i++){
        UIButton * testBtn = [[UIButton alloc]init];
        testBtn.frame = CGRectMake(0, 100+100*i, ScreenW, 48);
        testBtn.tag = 100+i;
        [testBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (i == 0){
            [testBtn setTitle:@"动态实例化" forState:UIControlStateNormal];
            [testBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [testBtn setTitle:@"静态实例化" forState:UIControlStateNormal];
            [testBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [testBtn setTitle:@"隐式实例化" forState:UIControlStateNormal];
            [testBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:testBtn];
    }
}

-(void)test:(UIButton *)btn{
    if (btn.tag == 100){
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(toGoThread:) object:nil];
        [thread start];
    }else if (btn.tag == 101){
        [NSThread detachNewThreadSelector:@selector(toGoThread:) toTarget:self withObject:nil];
    }else{
        [self performSelectorInBackground:@selector(toGoThread:) withObject:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setOperation{
//    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(toGoThread:) object:@{@"demo":@"Vals"}];
//    //[invocationOperation start];//直接会在当前线程主线程执行
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    [queue addOperation:invocationOperation];

    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self performMain:@{@"demo":@"Vals"}];
    }];

    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOperation];
}

-(void) toGoThread:(NSThread *)thread{
    [self performSelectorOnMainThread:@selector(performMain:) withObject:@{@"demo":@"Vals"} waitUntilDone:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新界面
        STLog(@"主线程执行");
    });

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 更新界面
        STLog(@"主线程执行1");
    }];
}

-(void) performMain:(NSDictionary *)dict{
    STLog(@"开线程  %@",[dict objectForKey:@"demo"]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
