//
//  UIView+BSView.m
//  百思不得姐
//
//  Created by 张树 on 16/5/13.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "UIView+BSView.h"

@implementation UIView (BSView)

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (BOOL)isShowingOnWindow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框,本来以superview为基准的，现在变成以window为基准
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBounds = keyWindow.bounds;
    
    //判断是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBounds);
    
    return !self.hidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
    
}

@end
