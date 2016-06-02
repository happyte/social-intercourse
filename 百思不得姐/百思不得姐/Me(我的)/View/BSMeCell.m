//
//  BSMeCell.m
//  百思不得姐
//
//  Created by 张树 on 16/6/2.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSMeCell.h"

@implementation BSMeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //通用的进行设置
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textColor = [UIColor darkGrayColor];
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

//cell设置背景图片，uiview属性的只能通过画
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"mainCellBackground"]drawInRect:rect];
}


//对cell内部的子控件进行布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame)+10;
   
}

@end
