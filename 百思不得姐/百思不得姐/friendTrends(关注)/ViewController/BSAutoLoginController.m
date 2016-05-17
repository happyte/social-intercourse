//
//  BSAutoLoginController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/16.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSAutoLoginController.h"

@interface BSAutoLoginController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end

@implementation BSAutoLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bgImage atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//modal退出当前页面
- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//登录下一个界面
- (IBAction)login {
    [self.view endEditing:YES];
}

- (IBAction)registerAccount {
    if (self.leftConstraint.constant == 0) {
        self.leftConstraint.constant -= self.view.width;
    }
    else {
        self.leftConstraint.constant = 0;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}



@end
