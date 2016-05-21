//
//  BSPictureView.m
//  百思不得姐
//
//  Created by 张树 on 16/5/21.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSPictureView.h"
#import <UIImageView+WebCache.h>
#import "BSTopics.h"
#import "BSProgressView.h"
#import <DALabeledCircularProgressView.h>

@interface BSPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIButton *seebigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet BSProgressView *progressView;

@end

@implementation BSPictureView

//通过xib加载，
- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.bigImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPicture:)]];
}

- (void)showBigPicture:(UITapGestureRecognizer *)tap {
    NSLog(@"-------------");
}

+ (instancetype)pictureView {
    //加载xib
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (void)setTopic:(BSTopics *)topic {
    _topic = topic;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = receivedSize*1.0/expectedSize;
        [self.progressView setProgress:progress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    //是大图显示放大按钮
    self.seebigBtn.hidden = (topic.isbigImage? NO:YES);
    //根据文件扩展名判断是否为gif图
    NSString *extension = topic.large_image.pathExtension;
    self.gifImageView.hidden = ([extension isEqualToString:@"gif"]? NO:YES);

}

@end
