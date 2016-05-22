//
//  BSTopics.h
//  百思不得姐
//
//  Created by 张树 on 16/5/19.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTopics : NSObject
//头像
@property(nonatomic,strong)NSString *profile_image;
//昵称
@property(nonatomic,strong)NSString *name;
//发布时间
@property(nonatomic,strong)NSString *created_at;
//顶
@property(nonatomic,strong)NSString *ding;
//踩
@property(nonatomic,strong)NSString *cai;
//转发
@property(nonatomic,strong)NSString *repost;
//评论
@property(nonatomic,strong)NSString *comment;
//Vip标志
@property(nonatomic,assign,getter=issina_v)BOOL sina_v;
//内容
@property(nonatomic,strong)NSString *text;
//小图片的URL
@property(nonatomic,strong)NSString *small_image;
//大图片的URL
@property(nonatomic,strong)NSString *large_image;
//中图片的URL
@property(nonatomic,strong)NSString *middle_image;
//图片、视频、声音返回的高度
@property(nonatomic,assign)CGFloat height;
//图片、视频、声音返回的宽度
@property(nonatomic,assign)CGFloat width;
//控制器的类型
@property(nonatomic,assign)BSType type;

//自定义属性
@property(nonatomic,assign)CGFloat cellHeight;
//pictureview的frame
@property(nonatomic,assign)CGRect pictureFrame;
//是否为大图，超出范围需要点击按钮显示的
@property(nonatomic,assign,getter=isbigImage)BOOL bigImage;
//存储下载进度
@property(nonatomic,assign)CGFloat progress;

@end
