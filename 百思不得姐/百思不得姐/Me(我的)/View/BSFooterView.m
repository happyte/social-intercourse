//
//  BSFooterView.m
//  百思不得姐
//
//  Created by 张树 on 16/6/2.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSFooterView.h"
#import "BSSquare.h"
#import "BSVerticalButton.h"
#import "BSSquareButton.h"
#import "BSWebViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>

@interface BSFooterView()

@property(nonatomic,strong)NSArray *squareArray;

@end

@implementation BSFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载网络数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            self.squareArray = [BSSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self setFooter:self.squareArray];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
        }];

    }
    return self;
}

- (void)setFooter:(NSArray *)array {
    NSUInteger maxCols = 5;
    CGFloat buttonW = BSScreenW/maxCols;
    CGFloat buttonH = buttonW;
    for (NSUInteger i = 0; i < array.count; i++) {
        BSSquareButton *button = [BSSquareButton buttonWithType:UIButtonTypeCustom];
        NSUInteger row = i/maxCols;
        NSUInteger col = i%maxCols;
        button.frame = CGRectMake(col*buttonW, row*buttonH, buttonW, buttonH);
        //添加view
        [self addSubview:button];
        //设置数据,传递模型
        button.square = array[i];
        //设置点击方法
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    //计算footerView的高度,只有button在footerview上才能点击
    NSUInteger maxRows = (array.count + maxCols -1)/maxCols;
    self.height = maxRows * buttonH;
}

- (void)buttonClick:(BSSquareButton *)button {
    //跳转界面,拿出导航控制器
    if ([button.square.url hasPrefix:@"http:"]) {
        UITabBarController *vc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *navVc = (UINavigationController *)vc.selectedViewController;
        //navVc是BSNavigationController类型的，重写了那个函数
        BSWebViewController *webVc = [[BSWebViewController alloc]init];
        //传递模型，需要模型的url
        webVc.square = button.square;
        [navVc pushViewController:webVc animated:YES];
        //modal函数可以直接拿[UIApplication sharedApplication].keyWindow.rootViewController去present
    }
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
   // [[UIImage imageNamed:@"mainCellBackground"]drawInRect:rect];
}

@end
