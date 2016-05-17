//
//  BSRecommandController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSRecommandController.h"
#import "BSRecommendCategory.h"
#import "BSRecommendUser.h"
#import "BSRecommendCategotyTableViewCell.h"
#import "BSRecommendUserTableViewCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface BSRecommandController ()<UITableViewDelegate,UITableViewDataSource>
//左边类别tableView
@property (weak, nonatomic) IBOutlet UITableView *recommendCategoryTableView;
//右边用户tableView
@property (weak, nonatomic) IBOutlet UITableView *recommendUserTableView;
//左边存放类别的模型数组
@property(nonatomic,strong)NSMutableArray *categories;
//右边存放用户组的模型数组
@property(nonatomic,strong)NSMutableArray *users;
@end

@implementation BSRecommandController

static NSString *CategoryID = @"category";
static NSString *UserID = @"user";

- (void)viewDidLoad {

    [super viewDidLoad];
    //tableview初始化
    [self setUpTableView];
    //刷新初始化
    [self setUpRefresh];
    //加载recommendCategoryTableView数据
    [self setUpCategoryTableView];
}

#pragma mark - <初始化类别tableview>
- (void)setUpCategoryTableView {
    //向服务器请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        [SVProgressHUD show];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //要把字典数组转成模型数组，创建模型
        self.categories = [BSRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.recommendCategoryTableView reloadData];
        //默认选中首行
        [self.recommendCategoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        // 加载默认首行数据
        [self.recommendUserTableView.header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];

}
//初始化设置
- (void)setUpTableView {
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.recommendCategoryTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.recommendUserTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.recommendCategoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.recommendUserTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //设置行高
    self.recommendUserTableView.rowHeight = 70;
    //控制器的xib是init自动加载的，cell的xib自己手动加载
    [self.recommendCategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendCategotyTableViewCell class]) bundle:nil] forCellReuseIdentifier:CategoryID];
    [self.recommendUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:UserID];

}

//初始化上拉下拉
- (void)setUpRefresh {
    self.recommendUserTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.recommendUserTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.recommendUserTableView.footer.hidden = YES;
}
#pragma mark - <加载新用户，下拉>
- (void)loadNewUsers {
    //无论何时下拉，所有数据都需要重新加载，从第一页开始加载
    BSRecommendCategory *model = self.categories[self.recommendCategoryTableView.indexPathForSelectedRow.row];
    //向服务器请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = model.id;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //第一次进来下载页面为1
        model.currentPage = 1;
        //获得用户组总页数
        model.total = [responseObject[@"total"] integerValue];
        //下载成功后要把数据存起来，否则下次进来又重新下载了
        NSMutableArray *users = [BSRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //删除原有数据
        [model.usersArray removeAllObjects];
        //添加新数据
        [model.usersArray addObjectsFromArray:users];
        //加载cell
        [self.recommendUserTableView reloadData];
        //关闭下拉刷新
        [self.recommendUserTableView.header endRefreshing];
        //检查footer状态
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.recommendUserTableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];

}
#pragma mark - <加载更多用户，上拉>
- (void)loadMoreUsers {

    //取出选中类型的模型
    BSRecommendCategory *model = self.categories[self.recommendCategoryTableView.indexPathForSelectedRow.row];
    //向服务器请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = model.id;
    params[@"page"] = @(++model.currentPage);
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //下载成功后要把数据存起来，否则下次进来又重新下载了
        NSMutableArray *users = [BSRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //在已有模型数组的基础上继续添加模型
        [model.usersArray addObjectsFromArray:users];
        [self.recommendUserTableView reloadData];
        //停止刷新
        [self.recommendUserTableView.footer endRefreshing];
        //检查footer状态
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.recommendUserTableView.footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
}

#pragma mark - <检查footer状态>
- (void)checkFooterState {
     BSRecommendCategory *model = self.categories[self.recommendCategoryTableView.indexPathForSelectedRow.row];
    //最终加载完成，模型总数等于json返回的总数
    if (model.usersArray.count == model.total) {
        [self.recommendUserTableView.footer noticeNoMoreData];
    }
    else {
        [self.recommendUserTableView.footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.recommendCategoryTableView) {
         return self.categories.count;
    }
    else {
        //取出左边被选中的类别模型
        BSRecommendCategory *model = self.categories[self.recommendCategoryTableView.indexPathForSelectedRow.row];
        self.recommendUserTableView.footer.hidden = (model.usersArray.count == 0);
        return model.usersArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.recommendCategoryTableView) {
        BSRecommendCategotyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryID];
        BSRecommendCategory *model = self.categories[indexPath.row];
        cell.model = model;
        return cell;
    }
    else {
        BSRecommendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserID];
        //取出左边被选中的类别模型
        BSRecommendCategory *model = self.categories[self.recommendCategoryTableView.indexPathForSelectedRow.row];
        //usersArray本身就是个模型数组
        cell.model = model.usersArray[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获得模型
    BSRecommendCategory *model = self.categories[indexPath.row];
    //第一次点击
    if (model.usersArray.count != 0) {
        //已经下载过了,避免重复下载
        [self.recommendUserTableView reloadData];
    }
    else {
        //为了防止网络加载缓慢停留在上一个界面
        [self.recommendUserTableView reloadData];
        //开始下拉刷新,进入loadNewUsers函数中
        [self.recommendUserTableView.header beginRefreshing];
    }

}
@end
