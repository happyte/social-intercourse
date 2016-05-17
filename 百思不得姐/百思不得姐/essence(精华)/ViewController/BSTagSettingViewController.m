//
//  BSTagSettingViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/16.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTagSettingViewController.h"
#import "BSTagSettingTableViewCell.h"
#import "BSTag.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>

@interface BSTagSettingViewController ()

@property(nonatomic,strong)NSMutableArray *tagsArray;

@end

@implementation BSTagSettingViewController

static NSString *tagID = @"tag";

- (NSMutableArray *)tagsArray {
    if (_tagsArray == nil) {
        _tagsArray = [NSMutableArray array];
    }
    return _tagsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self loadTags];

}

- (void)setUpTableView {
    self.navigationItem.title = @"我的关注";
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSTagSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:tagID];
}

- (void)loadTags {
    //向服务器请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action	"] = @"sub";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        [SVProgressHUD show];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.tagsArray = [BSTag objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSTagSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID];
    BSTag *model = self.tagsArray[indexPath.row];
    cell.recommendTag = model;
    return cell;
}



@end
