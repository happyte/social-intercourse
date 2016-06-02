//
//  BSSquareButton.m
//  百思不得姐
//
//  Created by 张树 on 16/6/2.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSSquareButton.h"
#import "BSSquare.h"
#import <UIButton+WebCache.h>

@implementation BSSquareButton

//通用的都放在init里面设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)setSquare:(BSSquare *)square {
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置约束需要4个条件不能少
    self.imageView.y = self.height*0.2;
    self.imageView.width = self.width*0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width*0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;

}
@end
