//
//  BSRecommendCategotyTableViewCell.m
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSRecommendCategotyTableViewCell.h"
#import "BSRecommendCategory.h"

@interface BSRecommendCategotyTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *IndictorView;

@end

@implementation BSRecommendCategotyTableViewCell

- (void)awakeFromNib {
   
}

- (void)setModel:(BSRecommendCategory *)model {
    _model = model;
    self.textLabel.text = model.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //textLabel本来是占据整个cell的，现在减少高度，下面可以放高度为1的白条
    self.textLabel.y = 2;
    self.textLabel.height = self.height - 2*self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.IndictorView.hidden = !selected;
    self.backgroundColor = selected? [UIColor whiteColor]:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.textLabel.textColor = selected? [UIColor colorWithRed:219/255.0 green:21/255.0 blue:26/255.0 alpha:1.0]:[UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1.0];
}

@end
