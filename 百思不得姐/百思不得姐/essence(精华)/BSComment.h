//
//  BSComment.h
//  百思不得姐
//
//  Created by 张树 on 16/5/26.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSUser;

@interface BSComment : NSObject

/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户模型，本来是个字典 */
@property(nonatomic,strong)BSUser *user;
/** id */
@property(nonatomic,strong)NSString *ID;
//voiceuri
@property(nonatomic,strong)NSString *voiceuri;
//voicetime
@property(nonatomic,strong)NSString *voicetime;

@end
