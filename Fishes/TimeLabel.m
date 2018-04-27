//
//  TimeLabel.m
//  Fishes
//
//  Created by test on 2018/4/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "TimeLabel.h"

@implementation TimeLabel

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
        _descTimer = @"2100-10-01 00:00:00";
    }
    return self;
}

- (void)timeHeadle{

    [self getInTimeWithStr:_descTimer];
}


-(void)getInTimeWithStr:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];

    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];

    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;

    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    if(hours<10)
        hoursStr = [NSString stringWithFormat:@"0%d",hours];
    else
        hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        self.attributedText = [FormatDs returnAttrStr:@"00 : 00 : 00"];
        _countStop(@{@"stopCount":@YES}, YES);
        [self.timer invalidate];
    }else if (days) {
        self.attributedText = [FormatDs returnAttrStr:[NSString stringWithFormat:@"%@ : %@ : %@ : %@", dayStr,hoursStr, minutesStr,secondsStr]];
    }else{
        self.attributedText = [FormatDs returnAttrStr:[NSString stringWithFormat:@"%@ : %@ : %@", hoursStr, minutesStr,secondsStr]];
    }
}
@end
