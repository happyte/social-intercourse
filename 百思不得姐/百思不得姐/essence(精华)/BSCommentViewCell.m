//
//  BSCommentViewCell.m
//  百思不得姐
//
//  Created by 张树 on 16/5/28.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSCommentViewCell.h"
#import "BSComment.h"
#import "BSUser.h"
#import <UIImageView+WebCache.h>

@interface BSCommentViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likecountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation BSCommentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

//二者缺一不可，第一个成为第一响应者，第二个去掉所有默认的选项
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)setComment:(BSComment *)comment {
    _comment = comment;
    //头像
    [self.profileImageView setHeaderView:comment.user.profile_image];
    //性别头像
    if ([comment.user.sex isEqualToString:female]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    else {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }
    self.screennameLabel.text = comment.user.username;
    self.likecountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.contentLabel.text = comment.content;
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:comment.voicetime forState:UIControlStateNormal];
    }
    else {
        self.voiceButton.hidden = YES;
    }
}

@end
