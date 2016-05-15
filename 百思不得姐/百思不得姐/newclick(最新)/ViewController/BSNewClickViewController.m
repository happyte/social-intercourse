//
//  BSNewClickViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSNewClickViewController.h"

@interface BSNewClickViewController ()

@end

@implementation BSNewClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    UIImageView *MainVc = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];;
    self.navigationItem.titleView = MainVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
