//
//  BSBaseTableViewController.h
//  百思不得姐
//
//  Created by 张树 on 16/5/20.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSBaseTableViewController : UITableViewController

typedef enum {
    AllType   = 1,
    VideoType = 41,
    PicType   = 10,
    VoiceType = 31,
    WordType  = 29,
}BSType;
//这个参数是需要其它控制器传进来的
@property(nonatomic,assign)BSType type;

@end
