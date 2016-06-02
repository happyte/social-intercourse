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
#import "BSVoiceView.h"
#import "BSVideoView.h"
#import "BSComment.h"
#import "BSUser.h"

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
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property(nonatomic,weak)BSPictureView *pictureView;
@property(nonatomic,weak)BSVoiceView *voiceView;
@property(nonatomic,weak)BSVideoView *videoView;

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

- (BSVoiceView *)voiceView {
    if (_voiceView == nil) {
        BSVoiceView *view = [BSVoiceView voiceView];
        [self.contentView addSubview:view];
        _voiceView = view;
    }
    return _voiceView;
}

- (BSVideoView *)videoView {
    if (_videoView == nil) {
        BSVideoView *view = [BSVideoView videoView];
        [self.contentView addSubview:view];
        _videoView = view;
    }
    return _videoView;
}

- (void)awakeFromNib {
    // Initialization code
}

//加载xib
+ (instancetype)cell {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(BSTopics *)topic {
   
   _topic = topic;
    [self.profileImageView setHeaderView:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createLabel.text = topic.created_at;
    self.content_text.text = topic.text;
    self.Vip.hidden = !topic.issina_v;
    [self setupButtonTitle:self.dingBtn withPlaceholder:topic.ding];
    [self setupButtonTitle:self.caiBtn withPlaceholder:topic.cai];
    [self setupButtonTitle:self.repostBtn withPlaceholder:topic.repost];
    [self setupButtonTitle:self.commentBtn withPlaceholder:topic.comment];

    //要加载cell的控件，肯定是到cell中写
    if (topic.type == PicType) {          //图片
        //传递模型,显示图片
        self.pictureView.topic = topic;
        //设置frame，计算cellHeight的时候就已经算出pictureFrame了
        self.pictureView.frame = topic.pictureFrame;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    else if (topic.type == VoiceType) {   //声音
        //传递模型
        self.voiceView.topic = topic;
        //将已经得到的frame设置上去
        self.voiceView.frame = topic.voiceFrame;
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    else if (topic.type == VideoType) {   //视频
        //传递模型
        self.videoView.topic = topic;
        //将已经得到的frame设置上去
        self.videoView.frame = topic.videoFrame;
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    else {                //段子，不需要单独设置全部，因为全部页面的模型的type不是一样的，包含了所有类型
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    //添加显示评论的内容
    BSComment *cmt = [topic.top_cmt firstObject];
    if (cmt) { //显示
        self.commentView.hidden = NO;
        self.commentLabel.text = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
    }
    else {
        self.commentView.hidden = YES;
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
