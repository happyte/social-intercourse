//
//  BSProgressView.m
//  百思不得姐
//
//  Created by 张树 on 16/5/21.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSProgressView.h"

@implementation BSProgressView

- (void)awakeFromNib {
    
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    self.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress*100)];
}

@end
