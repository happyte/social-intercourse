//
//  UIImageView+BSHeaderView.m
//  百思不得姐
//
//  Created by 张树 on 16/6/2.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "UIImageView+BSHeaderView.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (BSHeaderView)

- (void)setHeaderView:(NSString *)url {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image? [image circleImage]:placeholder;
    }];

}

@end
