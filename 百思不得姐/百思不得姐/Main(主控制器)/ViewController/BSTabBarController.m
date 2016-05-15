//
//  BSTabBarController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

//自定义TabBarController控制器
#import "BSTabBarController.h"
#import "BSEssenceViewController.h"
#import "BSMeViewController.h"
#import "BSFriendTrendsViewController.h"
#import "BSNewClickViewController.h"
#import "BSNavigationController.h"
#import "BSTabBar.h"

@interface BSTabBarController ()
@property(nonatomic,strong)NSMutableDictionary *attributes;
@property(nonatomic,strong)NSMutableDictionary *selectattributes;
@end

@implementation BSTabBarController


- (NSMutableDictionary *)attributes {
    if (_attributes == nil) {
        _attributes = [NSMutableDictionary dictionary];
        _attributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        _attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    }
    return _attributes;
}

- (NSMutableDictionary *)selectattributes {
    if (_selectattributes == nil) {
        _selectattributes = [NSMutableDictionary dictionary];
        _selectattributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        _selectattributes[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    }
    return _selectattributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setUpChildController];
    [self setUpTabBar];
    
}

- (void)setUpChildController {
    BSEssenceViewController *essenceVc = [[BSEssenceViewController alloc]init];
    [self setUpTabBarItem:essenceVc title:@"精华" Image:@"tabBar_essence_icon" SelectedImage:@"tabBar_essence_click_icon"];
    
    
    BSNewClickViewController *newVc = [[BSNewClickViewController alloc]init];
    [self setUpTabBarItem:newVc title:@"最新" Image:@"tabBar_new_icon" SelectedImage:@"tabBar_new_click_icon"];
    
    
    BSFriendTrendsViewController *friendTrendsVc = [[BSFriendTrendsViewController alloc]init];
    [self setUpTabBarItem:friendTrendsVc title:@"关注" Image:@"tabBar_friendTrends_icon" SelectedImage:@"tabBar_friendTrends_click_icon"];
    
    
    BSMeViewController *meVc = [[BSMeViewController alloc]init];
    [self setUpTabBarItem:meVc title:@"我" Image:@"tabBar_me_icon" SelectedImage:@"tabBar_me_click_icon"];
    
}

- (void)setUpTabBarItem:(UIViewController *)vc title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedimage
{
    
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedimage];
    vc.tabBarItem.title = title;
    [vc.tabBarItem setTitleTextAttributes:self.attributes forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:self.selectattributes forState:UIControlStateSelected];
    // 包装成导航控制器，根控制器为vc
    BSNavigationController *nav = [[BSNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (void)setUpTabBar {
    //替换成自定义tabBar,以前的方法是移除再添加，再把模型传过去,都是自定义的
    [self setValue:[[BSTabBar alloc]init] forKey:@"tabBar"];
}


@end
