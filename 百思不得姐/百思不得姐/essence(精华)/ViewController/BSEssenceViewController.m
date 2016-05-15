//
//  BSEssenceViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSEssenceViewController.h"

@interface BSEssenceViewController ()

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置每个控制器view的颜色
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //设置导航条的内容
    UIImageView *MainVc = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];;
    self.navigationItem.titleView = MainVc;
}


@end
