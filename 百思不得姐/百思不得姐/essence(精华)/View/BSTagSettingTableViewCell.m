//
//  BSTagSettingTableViewCell.m
//  百思不得姐
//
//  Created by 张树 on 16/5/16.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTagSettingTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "BSTag.h"

@interface BSTagSettingTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *list_name;
@property (weak, nonatomic) IBOutlet UILabel *theme_name;
@property (weak, nonatomic) IBOutlet UILabel *sub_name;

@end

@implementation BSTagSettingTableViewCell


- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommendTag:(BSTag *)recommendTag {
    _recommendTag = recommendTag;
    [self.list_name setHeaderView:recommendTag.image_list];
    //裁减图片不成功
    self.theme_name.text = recommendTag.theme_name;
    if (recommendTag.sub_number > 10000) {
        self.sub_name.text = [NSString stringWithFormat:@"%.1f万人关注",recommendTag.sub_number*1.0/10000];
    }
    else {
        self.sub_name.text = [NSString stringWithFormat:@"%zd人关注",recommendTag.sub_number];
    }

}

//通过该方法改变cell的frame
- (void)setFrame:(CGRect)frame {
 
    frame.origin.x = 5;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
