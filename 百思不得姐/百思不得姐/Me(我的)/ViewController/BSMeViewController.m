//
//  BSMeViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSMeViewController.h"


@interface BSMeViewController ()

@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.navigationItem.title = @"我的";
        UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] WithHighlighted:[UIImage imageNamed:@"mine-setting-icon-click"] WithController:self WithTarget:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] WithHighlighted:[UIImage imageNamed:@"mine-moon-icon-click"] WithController:self WithTarget:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];
}

- (void)settingClick {
    NSLog(@"%s",__func__);
}

- (void)moonClick {
    NSLog(@"%s",__func__);
}


@end
