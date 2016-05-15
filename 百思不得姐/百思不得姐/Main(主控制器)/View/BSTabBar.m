//
//  BSTabBar.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTabBar.h"

@interface BSTabBar()

@property(nonatomic,weak)UIButton *button;
@end

@implementation BSTabBar

+ (void)initialize {
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        //自定义按键
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        self.button = button;
    }
    return self;
}

- (void)layoutSubviews {
    //父类先需要调用布局函数
    [super layoutSubviews];
    self.button.bounds = CGRectMake(0, 0, self.button.currentBackgroundImage.size.width, self.button.currentBackgroundImage.size.height);
    self.button.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    //布局
    NSInteger index = 0;
    CGFloat y = 0;
    CGFloat width  = self.frame.size.width/5;
    CGFloat height = self.frame.size.height ;
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置frame
            CGFloat x = width*((index>1)? index+1:index);
            button.frame = CGRectMake(x, y, width, height);
            index++;
        }
    }
}

@end
