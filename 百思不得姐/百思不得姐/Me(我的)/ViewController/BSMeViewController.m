//
//  BSMeViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSMeViewController.h"
#import "BSMeCell.h"
#import "BSFooterView.h"


@interface BSMeViewController ()

@end

@implementation BSMeViewController

static NSString *MeId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupItem];
}

- (void)setupItem {
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] WithHighlighted:[UIImage imageNamed:@"mine-setting-icon-click"] WithController:self WithTarget:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] WithHighlighted:[UIImage imageNamed:@"mine-moon-icon-click"] WithController:self WithTarget:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];

}

- (void)setupTableView {
    self.tableView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSMeCell class] forCellReuseIdentifier:MeId];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.tableFooterView = [[BSFooterView alloc]init];
}

- (void)settingClick {
    NSLog(@"%s",__func__);
}

- (void)moonClick {
    NSLog(@"%s",__func__);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSMeCell *cell = [tableView dequeueReusableCellWithIdentifier:MeId];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"我的身份";
        cell.textColor = [UIColor blackColor];
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }
    return cell;
}

@end
