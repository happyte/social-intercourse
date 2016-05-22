//
//  BSShowBigPictureController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/22.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSShowBigPictureController.h"
#import "BSTopics.h"
#import "BSProgressView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface BSShowBigPictureController ()

@property(nonatomic,weak)UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BSProgressView *progressView;

@end

@implementation BSShowBigPictureController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.scrollView addSubview:imageView];
    self.bigImageView = imageView;
    //给图片添加手势，图片是不可交互的
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    //根据图片类型判断显示方式
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //图片真实显示的宽度和高度
    CGFloat imageW = screenW;
    CGFloat imageH = imageW*self.topic.height/self.topic.width;
    if (imageH > pictureViewMaxHeight) {   //超出显示范围
        self.scrollView.contentSize = CGSizeMake(0, imageH);
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
    }
    else {
        imageView.size = CGSizeMake(imageW, imageH);
        imageView.centerY = self.view.centerY;
    }
    //如果进入大图前还没下载完成，sd在这个方法是继续下载的，进度应该是跟上之前的，不会重新下载。最好把之前的progress进度传进来，否则网络慢的话会显示有问题
    [self.progressView setProgress:self.topic.progress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = receivedSize*1.0/expectedSize;
        [self.progressView setProgress:progress animated:NO];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}


- (IBAction)save {
    if (self.bigImageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还未下载完成"];
        return;
    }
    //保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.bigImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
