//
//  BSRecommendUser.h
//  百思不得姐
//
//  Created by 张树 on 16/5/15.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendUser : NSObject

//头像url
@property(nonatomic,strong)NSString *header;
//粉丝数目
@property(nonatomic,assign)NSInteger fans_count;
//昵称
@property(nonatomic,strong)NSString *screen_name;

@end
