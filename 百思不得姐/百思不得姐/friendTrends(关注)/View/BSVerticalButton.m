//
//  BSVerticalButton.m
//  百思不得姐
//
//  Created by 张树 on 16/5/16.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSVerticalButton.h"

@implementation BSVerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)awakeFromNib {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//这个是控件重新布局，所以要调用layoutSubviews，而修改控件大小，是调用setFrame
- (void)layoutSubviews {

    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.width;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

}
@end
