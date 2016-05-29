//
//  BSVideoView.h
//  百思不得姐
//
//  Created by 张树 on 16/5/23.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTopics;

@interface BSVideoView : UIView
@property(nonatomic,strong)BSTopics *topic;

+ (instancetype)videoView;

@end
