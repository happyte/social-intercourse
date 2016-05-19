//
//  BSVoiceTableViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/18.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSVoiceTableViewController.h"

@interface BSVoiceTableViewController ()

@end

@implementation BSVoiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setuptableView];
}

- (void)setuptableView {
    CGFloat top = BSTitilesViewH+BSTitilesViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    //tableview占据的frame是整个屏幕，但是能显示的是下面一句话设置的
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"声音%zd",indexPath.row];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
@end
