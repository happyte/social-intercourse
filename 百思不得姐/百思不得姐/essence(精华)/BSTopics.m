//
//  BSTopics.m
//  百思不得姐
//
//  Created by 张树 on 16/5/19.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTopics.h"
#import <MJExtension.h>
#import "BSComment.h"
#import "BSUser.h"

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

//只需要在模型内加这一段代码，就可以替换属性
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image": @"image2",
             @"ID"          : @"id"
             };
}

//top_cmt是个数组，现在要把数组中的字典转成模型
+ (NSDictionary *)objectClassInArray {
    return @{@"top_cmt" : [BSComment class]};
}

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

- (CGFloat)cellHeight {
    
    //只计算一次cell高度
    if (_cellHeight == 0) {
        CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*cellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight = titleImageY + textH + cellMargin + bottomH;
            //判断控制器类型，根据类型计算cell的高度,type是服务器返回的数据
  
            //获得模型中pictureFrame的值
            CGFloat imageW = pictureViewWidth;
            CGFloat imageH = imageW*self.height/self.width;
        
            //模型是图片类型
            if (self.type == PicType) {
                if (imageH > pictureViewMaxHeight) {   //超出最大高度使用设置的最大高度,拿真正需要显示的高度比较
                    imageH = pictureViewBreakHeight;
                    self.bigImage = YES;
                }
            CGFloat pictureX = cellMargin;
            CGFloat pictureY = titleImageY + textH + cellMargin;
            //重新计算cell的高度
            self.pictureFrame = CGRectMake(pictureX, pictureY, imageW, imageH);
            _cellHeight += imageH + cellMargin;
        }
            //图片是声音类型
            else if (self.type == VoiceType) {
                CGFloat pictureX = cellMargin;
                CGFloat pictureY = titleImageY + textH + cellMargin;
                //重新计算cell的高度
                self.voiceFrame = CGRectMake(pictureX, pictureY, imageW, imageH);
                _cellHeight += imageH + cellMargin;
            }
            else if (self.type == VideoType) {
                CGFloat pictureX = cellMargin;
                CGFloat pictureY = titleImageY + textH + cellMargin;
                //重新计算cell的高度
                self.videoFrame = CGRectMake(pictureX, pictureY, imageW, imageH);
                _cellHeight += imageH + cellMargin;
            }
         //假如有最热评论，重新计算高度
        //取出第一个评论
        BSComment *cmt = [self.top_cmt firstObject];
        if (cmt) {
            NSString *comment = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
            CGFloat commentTextH = [comment boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += commentTextH + commentViewTitle + cellMargin;
        }
        _cellHeight += cellMargin;
    }
    return _cellHeight;
}

@end
