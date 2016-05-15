//
//  BSNavigationController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/14.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSNavigationController.h"

@interface BSNavigationController ()

@end

@implementation BSNavigationController

+ (void)initialize {
    //BSNavigationController类下的导航条进行统一设置，只会进来一次
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//重写push函数
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
    if (self.childViewControllers.count > 0) {
        //统一设置导航条
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        [returnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [returnBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [returnBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [returnBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [returnBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        returnBtn.size = CGSizeMake(70, 20);
        returnBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //设置为左对齐
        returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
        
         viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句话一定要写在后面，等设置好了再push进来，而且还可以push完进入viewdidload进行修改
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
