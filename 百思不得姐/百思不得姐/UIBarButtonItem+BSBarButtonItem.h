//
//  UIBarButtonItem+BSBarButtonItem.h
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BSBarButtonItem)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image WithHighlighted:(UIImage *)highlightimage WithController:(UIViewController *)vc WithTarget:(SEL)action;

@end
