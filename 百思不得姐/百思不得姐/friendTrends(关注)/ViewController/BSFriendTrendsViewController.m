//
//  BSFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSFriendTrendsViewController.h"
#import "BSRecommandController.h"

@interface BSFriendTrendsViewController ()

@end

@implementation BSFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] WithHighlighted:[UIImage imageNamed:@"friendsRecommentIcon-click"] WithController:self WithTarget:@selector(FriendTrendsClick)];
}

- (void)FriendTrendsClick {
    BSRecommandController *vc = [[BSRecommandController alloc]init];
    vc.title = @"推荐关注";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
