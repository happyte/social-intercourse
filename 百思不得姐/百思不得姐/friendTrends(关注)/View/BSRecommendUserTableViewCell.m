//
//  BSRecommendUserTableViewCell.m
//  百思不得姐
//
//  Created by 张树 on 16/5/15.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSRecommendUserTableViewCell.h"
#import "BSRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface BSRecommendUserTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;


@end

@implementation BSRecommendUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BSRecommendUser *)model {
    _model = model;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.screenName.text = model.screen_name;
    self.fansCount.text = [NSString stringWithFormat:@"%zd人关注",model.fans_count];

}

@end
