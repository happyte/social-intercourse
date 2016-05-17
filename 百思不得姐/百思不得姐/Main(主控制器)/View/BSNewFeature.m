//
//  BSNewFeature.m
//  百思不得姐
//
//  Created by 张树 on 16/5/17.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSNewFeature.h"

@interface BSNewFeature()


@end

@implementation BSNewFeature

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)showGuideView {
    //从同名的xib中加载
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close {
    [self removeFromSuperview];
}



@end
