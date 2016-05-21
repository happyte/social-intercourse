//
//  BSPictureView.h
//  百思不得姐
//
//  Created by 张树 on 16/5/21.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTopics;

@interface BSPictureView : UIView

/***传递BSTopics模型*/
@property(nonatomic,strong)BSTopics *topic;

+ (instancetype)pictureView;

@end
