//
//  BSCommentController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/27.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSCommentController.h"
#import "BSTopicCell.h"
#import "BSTopics.h"
#import "BSComment.h"
#import "BSCommentViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>

@interface BSCommentController ()<UIScrollViewDelegate>
//最底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//最热评论数组
@property(nonatomic,strong)NSArray *hotComments;
//最新评论数组，由于是不固定的，可以添加数据所以定义为可变数组
@property(nonatomic,strong)NSMutableArray *latestComments;
//纪录top_cmt模型数组
@property(nonatomic,strong)NSArray *saved_top_cmt;
//纪录总评论数
@property(nonatomic,assign)NSInteger total;
@end

@implementation BSCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupheaderView];
    [self setupRefresh];
}


- (void)setupheaderView {

    UIView *header = [[UIView alloc]init];
    //假如有跳转前有最热评论的话，应该跳转之后重新计算高度
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        //清0后不会加上top_cmt这段高度
        self.topic.top_cmt = nil;
        //高度清0，重新计算
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    BSTopicCell *cell = [BSTopicCell cell];
    //设置数据
    cell.topic = self.topic;
    cell.size = CGSizeMake(BSScreenW, self.topic.cellHeight);
    header.height = self.topic.cellHeight + cellMargin;
    [header addSubview:cell];
    //tableHeaderView的初始x,y,width都是已知的，height是需要自己设置的
    self.tableView.tableHeaderView = header;
    
}

//顶部工具条设置和键盘通知
- (void)setupBasic {
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"comment_nav_item_share_icon"] WithHighlighted:[UIImage imageNamed:@"comment_nav_item_share_icon_click"] WithController:self WithTarget:nil];
    //注册自定义评论cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSCommentViewCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    //计算自定义cell高度
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardframeChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //设置顶部间距，否则tableview直接到顶了
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)keyboardframeChange:(NSNotification *)note {
    //键盘的frame
    CGRect frame =[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //修改底部的约束
    self.bottomConstraint.constant = BSScreenH - frame.origin.y;
    [UIView animateWithDuration:duration animations:^{
        //及时做动画,约束都设定好了，动画可以逐渐修改
        [self.view layoutIfNeeded];
    }];
}

//通知在dealloc函数中需要销毁
- (void)dealloc {
    //还原数据
    self.topic.top_cmt = self.saved_top_cmt;
    [self.topic setValue:@0 forKey:@"cellHeight"];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setupRefresh {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden = YES;
    [self.tableView.header beginRefreshing];
}

//下拉刷新
- (void)loadNewComments {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //重新恢复下拉
        [self.tableView.footer beginRefreshing];
        NSInteger total = [responseObject[@"total"] integerValue];
        self.total = total;
        self.hotComments = [BSComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [BSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.latestComments.count >= total) {
            [self.tableView.footer noticeNoMoreData];
        }
        else {
            [self.tableView.footer endRefreshing];
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
    }];
}

//上拉刷新
- (void)loadMoreComments {
    //获得最新评论的最后一个元素的id
    BSComment *comment = [self.latestComments lastObject];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = comment.ID;

    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {

        NSArray *array = [BSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //添加新数据
        [self.latestComments addObjectsFromArray:array];
        //数据满了不显示尾部
        if (self.latestComments.count >= self.total) {
            [self.tableView.footer noticeNoMoreData];
        }
        //停止刷新
        else {
            [self.tableView.footer endRefreshing];
        }
        //加载新数据
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (self.hotComments.count == 0)? 1:2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger latestcount = self.latestComments.count;
    self.tableView.footer.hidden = (latestcount == 0);
    NSArray *array = [self choosehotorcommentArray:section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
   
    BSComment *comment = [self commentIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}

//选择最热评论还是最新评论模型数组
- (NSArray *)choosehotorcommentArray:(NSInteger)section {
    if (section == 0) {
        return (self.hotComments.count != 0)? self.hotComments:self.latestComments;
    }
    return self.latestComments;
}

//选择模型数组中的模型
- (BSComment *)commentIndexPath:(NSIndexPath *)indexPath {
    return [self choosehotorcommentArray:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //在header里包装一层label
    UILabel *label = [[UILabel alloc]init];
    label.x = cellMargin;
    label.width = 200;
    //label的高度跟随header变化
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0];
    [header addSubview:label];
    if (section == 0) {
        label.text = (self.hotComments.count == 0)? @"最新评论":@"最热评论";
    }
    else {
        label.text = @"最新评论";
    }
    return header;
}
@end
