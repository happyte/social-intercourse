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

@end
