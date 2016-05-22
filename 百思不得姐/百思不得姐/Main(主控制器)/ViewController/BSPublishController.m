//
//  BSPublishController.m
//  百思不得姐
//
//  Created by 张树 on 16/5/22.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSPublishController.h"
#import "BSVerticalButton.h"
#import <POP.h>

@interface BSPublishController ()
@property(nonatomic,weak)UIImageView *sloganView;
@end

@implementation BSPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加6个按钮
    NSArray *name = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    NSArray *imageName = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSUInteger count = name.count;
    NSUInteger maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 50;
    CGFloat buttonStartX = 20;
    CGFloat buttonStartY = (BSScreenH-2*buttonH)*0.5;
    CGFloat buttonMargin = (BSScreenW-2*buttonStartX-buttonW*maxCols)/(maxCols-1);
    for (NSUInteger i = 0; i < count; i++) {
        BSVerticalButton *button = [[BSVerticalButton alloc]init];
        [button setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
        [button setTitle:name[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        //计算frame
        NSUInteger row = i/maxCols;
        NSUInteger col = i%maxCols;
        CGFloat buttonX = buttonStartX + col*(buttonW+buttonMargin);
        CGFloat buttonY = buttonStartY + row*buttonH;
        //使用pop框架，改变frame往下掉,而且不需要再设置frame了，因为pop改变了frame
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY-BSScreenH, buttonW, buttonH)];
        anim.toValue   = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anim.springBounciness = 8;
        anim.springSpeed = 8;
        anim.beginTime = CACurrentMediaTime()+0.1*i;
        [button pop_addAnimation:anim forKey:nil];
    }
    //添加顶部图片
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    self.sloganView = slogan;
    [self.view addSubview:slogan];
    //中心约束
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(BSScreenW*0.5, BSScreenH*0.2-BSScreenH)];
    anim.toValue   = [NSValue valueWithCGPoint:CGPointMake(BSScreenW*0.5, BSScreenH*0.2)];
    anim.springBounciness = 8;
    anim.springSpeed = 8;
    anim.beginTime = CACurrentMediaTime()+0.1*count;
    [slogan pop_addAnimation:anim forKey:nil];

}

- (void)btnClick:(UIButton *)button {
  [self cancel:^(int num) {
      if (button.tag == 0) {
          NSLog(@"%d发视频",num);
      }
  }];
}

- (IBAction)cancel {
    [self cancel:nil];
}


//定义block，
//block传递参数类型(返回值(^)(参数))函数名
- (void)cancel:(void(^)(int))completeion{
    //让按钮往下掉
    NSUInteger index = 2;
    NSUInteger count = self.view.subviews.count;

    for (NSUInteger i = index; i<count ; i++) {
        UIView *subview = self.view.subviews[i];
        //这里不需要计算frame，因为已经添加到view中，只需要设置最后的位置
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue  = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, subview.centerY+BSScreenH)];
        anim.beginTime = CACurrentMediaTime()+0.1*i;
        [subview pop_addAnimation:anim forKey:nil];
        if (i == count-1) {
            //最后一个控件pop完退出控制器，写在外面会直接退出
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                if (completeion) {
                    completeion(10);
                }
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self cancel:nil];
}

//block函数定义方法
int (^myBlock)(int,int)=^(int num1,int num2){
    return 10;
};
@end
