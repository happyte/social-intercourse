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
#import "BSPictureView.h"

@interface BSTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *Vip;
@property (weak, nonatomic) IBOutlet UILabel *content_text;
@property(nonatomic,weak)BSPictureView *pictureView;

@end

@implementation BSTopicCell

- (BSPictureView *)pictureView {
    if (_pictureView == nil) {
        BSPictureView *view = [BSPictureView pictureView];
        [self.contentView addSubview:view];
        _pictureView = view;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setTopic:(BSTopics *)topic {
   _topic = topic;
   [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createLabel.text = topic.created_at;
    self.content_text.text = topic.text;
    self.Vip.hidden = !topic.issina_v;
    [self setupButtonTitle:self.dingBtn withPlaceholder:topic.ding];
    [self setupButtonTitle:self.caiBtn withPlaceholder:topic.cai];
    [self setupButtonTitle:self.repostBtn withPlaceholder:topic.repost];
    [self setupButtonTitle:self.commentBtn withPlaceholder:topic.comment];
    //要加载cell的控件，肯定是到cell中写
    if (topic.type == PicType) {
        //传递模型,显示图片
        self.pictureView.topic = topic;
        //设置frame
        self.pictureView.frame = topic.pictureFrame;
        //每次创建view，会导致重叠问题
//        BSPictureView *view = [BSPictureView pictureView];
//        view.topic = topic;
//        [self.contentView addSubview:view];
//        view.frame = topic.pictureFrame;

    }
}

//数字大小设置
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
    frame.origin.x = cellMargin;
    frame.origin.y += cellMargin;
    frame.size.width -= 2*cellMargin;
    frame.size.height -= cellMargin;
    [super setFrame:frame];
}

@end
