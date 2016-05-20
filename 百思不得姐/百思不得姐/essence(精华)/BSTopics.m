//
//  BSTopics.m
//  百思不得姐
//
//  Created by 张树 on 16/5/19.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTopics.h"

@implementation BSTopics

/**
 今年
 今天
 1分钟内
 刚刚
 1小时内
 xx分钟前
 其他
 xx小时前
 昨天
 昨天 18:56:34
 其他
 06-23 19:56:23
 
 非今年
 2014-05-08 18:45:30
 */

//重写create_at的get方法
- (NSString *)created_at {
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    if ([create isThisYear]) { //今年
        if ([create isToday]) { //今天
            //计算差值
            NSDateComponents *cmps = [now deltaFrom:create];
            if (cmps.hour) { //大于一小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }
            else if (cmps.minute) { // 一分钟外一小时内
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }
            else {
                return @"刚刚";
            }
        }
        else if ([create isYesterday]) { //昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else {  //其它
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }
    else { //非今年
        return _created_at;
    }
}

@end
