//
//  BSEssenceViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSTagSettingViewController.h"
#import "BSAllTableViewController.h"
#import "BSVideoTableViewController.h"
#import "BSPictureTableViewController.h"
#import "BSWordTableViewController.h"
#import "BSVoiceTableViewController.h"

@interface BSEssenceViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton *selectedBtn;
@property(nonatomic,strong)UIView *indictorView;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    [self setUpAllChildControllers];
    [self setUpNav];
    [self setUpScrollView];
    [self setUpTitleView];
}

//初始化导航条内容
- (void)setUpNav {
    //设置导航条的内容
    UIImageView *MainVc = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];;
    self.navigationItem.titleView = MainVc;
    //设置导航条左部
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] WithHighlighted:[UIImage imageNamed:@"MainTagSubIconClick"] WithController:self WithTarget:@selector(tagClick)];
}

//初始化顶部标签栏
- (void)setUpTitleView {

    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 64, self.view.width, 35);
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    UIView *indictorView = [[UIView alloc]init];
    indictorView.backgroundColor = [UIColor redColor];
    //确定高度和y
    indictorView.height = 2;
    indictorView.y = titleView.height - indictorView.height;
    self.indictorView = indictorView;
    
    NSArray *nameArray = @[@"全部",@"视频",@"图片",@"声音",@"段子"];
    CGFloat width = self.view.width/nameArray.count;
    CGFloat height = titleView.height-indictorView.height;
    for (int i = 0; i < nameArray.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
         button.frame = CGRectMake(i*width, 0, width, height);

        [titleView addSubview:button];
        if (i == 0) {
            //默认选中第一个
            button.enabled = NO;
            self.selectedBtn = button;
            //这句话要加上，因为此时button没有进行布局
            //[button.titleLabel sizeToFit];
            [titleView layoutIfNeeded];
            self.indictorView.width = button.titleLabel.width;
            self.indictorView.centerX = button.centerX;
            [self scrollViewDidEndScrollingAnimation:self.scrollView];
        }
    }
    [titleView addSubview:indictorView];
}

/*
 *初始化子控制器
 */
- (void)setUpAllChildControllers {
    BSAllTableViewController *allVc = [[BSAllTableViewController alloc]init];
    [self addChildViewController:allVc];
    BSVideoTableViewController *videoVc = [[BSVideoTableViewController alloc]init];
    [self addChildViewController:videoVc];
    BSPictureTableViewController *picVc = [[BSPictureTableViewController alloc]init];
    [self addChildViewController:picVc];
    BSVoiceTableViewController *voiceVc = [[BSVoiceTableViewController alloc]init];
    [self addChildViewController:voiceVc];
    BSWordTableViewController *wordVc = [[BSWordTableViewController alloc]init];
    [self addChildViewController:wordVc];
}

/*
 *初始化ScrollView
 */
- (void)setUpScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.frame = self.view.frame;
    contentView.contentSize = CGSizeMake(self.view.width*self.childViewControllers.count, 0);
    [self.view insertSubview:contentView atIndex:0];
    self.scrollView = contentView;
}

//监听顶部标签栏按键点击
- (void)headClick:(UIButton *)button {
   
    //为了防止重复点击
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    //移动滚动条
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width*button.tag;
    [self.scrollView setContentOffset:offset animated:YES];
    //上面拿到的setContentOffset数据好像不准，进入代理方法才正确
    
    [UIView animateWithDuration:0.25 animations:^{
        //更改indictorview的位置
        //要先设置宽度，再改变中心点位置
        self.indictorView.width = button.titleLabel.width;
        self.indictorView.centerX = button.centerX;
    }];
}

//监听左边tabbar点击
- (void)tagClick {
    BSTagSettingViewController *tagVc = [[BSTagSettingViewController alloc]init];
    [self.navigationController pushViewController:tagVc animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
/*
 *结束动画会来到这个方法，前面调用了[self.scrollView setContentOffset:offset animated:YES]
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.width;
    //根据索引拿出相应的控制器
    UITableViewController *vc = self.childViewControllers[index];
    //进行frame设置
    vc.view.frame = CGRectMake(self.scrollView.contentOffset.x, 0, self.scrollView.width, self.scrollView.height);

//    CGFloat top = CGRectGetMaxY(self.titleView.frame);
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    //tableview占据的frame是整个屏幕，但是能显示的是下面一句话设置的
//    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.width;
    [self headClick:self.titleView.subviews[index]];
}

@end
