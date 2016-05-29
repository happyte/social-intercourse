//
//  BSVoiceView.m
//  百思不得姐
//
//  Created by 张树 on 16/5/23.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSVoiceView.h"
#import "BSTopics.h"
#import <UIImageView+WebCache.h>
#import "BSShowBigPictureController.h"

@interface BSVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (weak, nonatomic) IBOutlet UILabel *playtime;
@property (weak, nonatomic) IBOutlet UIImageView *voiceimageView;

@end

@implementation BSVoiceView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.voiceimageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBig:)]];
}

- (void)showBig:(UITapGestureRecognizer *)tap {
    //进入大图显示大图界面,控制器init方法会自动去加载xib
    BSShowBigPictureController *bigVc = [[BSShowBigPictureController alloc]init];
    //传递模型
    bigVc.topic = self.topic;
    //modal跳转到bigVc,在uiview中只能拿到根控制器去跳转
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigVc animated:YES completion:nil];
}

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setTopic:(BSTopics *)topic {
    _topic = topic;
    [self.voiceimageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    if (topic.playcount > 10000) {
         self.playcount.text = [NSString stringWithFormat:@"%.1f万播放",topic.playcount*1.0/10000];
    }
    else {
         self.playcount.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    }
    //分，秒
    NSInteger minute = topic.voicetime/60;
    NSInteger second = topic.voicetime%60;
    //2代表保留2位，0表示空白的地方填充0
    self.playtime.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}


- (IBAction)voiceBtn {

}


@end
