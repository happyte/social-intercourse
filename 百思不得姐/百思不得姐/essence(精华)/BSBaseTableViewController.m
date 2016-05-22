//
//  BSWordTableViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/18.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSBaseTableViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "BSTopics.h"
#import "BSTopicCell.h"

@interface BSBaseTableViewController ()

@property(nonatomic,strong)NSMutableArray *topics;
@property(nonatomic,strong)NSString *maxtime;
@property(nonatomic,assign)NSInteger page;
/** 最新的请求参数 */
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation BSBaseTableViewController

static NSString *topicID = @"topic";

- (NSMutableArray *)topics {
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
    [self setuptableView];
    [self setUpRefresh];
}

- (void)setuptableView {
    CGFloat top = BSTitilesViewH+BSTitilesViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    //tableview占据的frame是整个屏幕，但是能显示的是下面一句话设置的
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}
//设置刷新控件
- (void)setUpRefresh {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    //自动根据下拉的位置改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    [self.tableView.header beginRefreshing];
    self.tableView.footer.hidden = YES;
}

//加载新用户
- (void)loadNewUsers {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =  @(self.type);
    self.params = params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        [SVProgressHUD show];
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //如果请求成功的参数不等于最新的参数，return
        if (self.params != params) {
            return ;
        }
        //蒙板消失
        [SVProgressHUD dismiss];
        //顶部停止刷新
        [self.tableView.header endRefreshing];
        //覆盖全部数据
        self.topics = [BSTopics objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //获得maxtime,下页加载时用
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
}

//加载更多用户
- (void)loadMoreUsers {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        [SVProgressHUD show];
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (self.params != params) {
            return ;
        }
        //蒙板消失
        [SVProgressHUD dismiss];
        //停止尾部刷新
        [self.tableView.footer endRefreshing];
        //这个值一定要获得
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //获得新数据
        NSArray *topicsArray = [BSTopics objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加新数据
        [self.topics addObjectsFromArray:topicsArray];
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

/**计算完高度后再来到这个函数**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID];
    self.tableView.footer.hidden = (self.topics.count == 0);
    BSTopics *topic = self.topics[indexPath.row];
    //所有cell的设置都在setTopic函数中完成
    cell.topic = topic;
    return cell;
}

/**先计算cell的高度再来到显示每个cell函数**/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    //取出对应的模型
    BSTopics *topic = self.topics[indexPath.row];
    //计算cell高度的过程中计算了图片的frame
    return topic.cellHeight;
}
@end
