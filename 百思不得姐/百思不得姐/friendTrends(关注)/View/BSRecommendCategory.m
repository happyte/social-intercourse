//
//  BSRecommendCategory.m
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSRecommendCategory.h"

@implementation BSRecommendCategory

- (NSMutableArray *)usersArray {
    if (_usersArray == nil) {
        _usersArray = [NSMutableArray array];
    }
    return _usersArray;
}

@end
