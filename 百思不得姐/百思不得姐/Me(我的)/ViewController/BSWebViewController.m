//
//  BSWebViewController.m
//  百思不得姐
//
//  Created by 张树 on 16/6/2.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSWebViewController.h"
#import <NJKWebViewProgress.h>

@interface BSWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation BSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.progress 必须为成员变量
    self.progress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.progress;
    //将self改为弱指针
    __weak typeof(self) weakSelf = self;
    //调用block块
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1);
    };
    //再将代理转为控制器本身
    self.progress.webViewProxyDelegate = self;
    self.navigationItem.title = self.square.name;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}


#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

@end
