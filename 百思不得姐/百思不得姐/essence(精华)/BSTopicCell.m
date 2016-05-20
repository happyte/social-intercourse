//
//  BSTopicCell.m
//  百思不得姐
//
//  Created by 张树 on 16/5/19.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTopicCell.h"
#import "BSTopics.h"
#import <UIImageView+WebCache.h>

@interface BSTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *Vip;

@end

@implementation BSTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(BSTopics *)topic {
   _topic = topic;
   [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createLabel.text = topic.created_at;
    self.Vip.hidden = !topic.issina_v;
    [self setupButtonTitle:self.dingBtn withPlaceholder:topic.ding];
    [self setupButtonTitle:self.caiBtn withPlaceholder:topic.cai];
    [self setupButtonTitle:self.repostBtn withPlaceholder:topic.repost];
    [self setupButtonTitle:self.commentBtn withPlaceholder:topic.comment];
}

- (void)setupButtonTitle:(UIButton *)button  withPlaceholder:(NSString *)placeholder {
    NSInteger count = [placeholder integerValue];
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count*1.0/10000];
    }
    else {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

//改变cell的frame
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y += 10;
    frame.size.width -= 2*10;
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
