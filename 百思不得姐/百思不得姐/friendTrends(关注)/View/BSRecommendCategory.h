//
//  BSRecommendCategory.h
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendCategory : NSObject

@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger count;
//用于存放下载完成的用户组数据
@property(nonatomic,strong)NSMutableArray *usersArray;
//用于存放用户组模型总个数
@property(nonatomic,assign)NSInteger total;
//用户组当前页数
@property(nonatomic,assign)NSInteger currentPage;
@end
