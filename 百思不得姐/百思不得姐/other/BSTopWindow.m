//
//  BSTopWindow.m
//  百思不得姐
//
//  Created by 张树 on 16/5/30.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTopWindow.h"

@implementation BSTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, BSScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];

}

+ (void)show {

    window_.hidden = NO;
}

- (void)windowClick {
    NSLog(@"-------------");
}

@end
