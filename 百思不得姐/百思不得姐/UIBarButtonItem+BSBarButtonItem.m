//
//  UIBarButtonItem+BSBarButtonItem.m
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "UIBarButtonItem+BSBarButtonItem.h"

@implementation UIBarButtonItem (BSBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image WithHighlighted:(UIImage *)highlightimage WithController:(UIViewController *)vc WithTarget:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightimage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
