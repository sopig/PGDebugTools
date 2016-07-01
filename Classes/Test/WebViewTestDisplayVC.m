//
//  WebViewTestVC.m
//  PGDebugTools
//
//  Created by 万昌军 on 16/6/18.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import "WebViewTestDisplayVC.h"

@interface WebViewTestDisplayVC ()<UIWebViewDelegate>



@end

@implementation WebViewTestDisplayVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    self.webView.scalesPageToFit = YES;//自动缩放来适应屏幕
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;//自动检测网页上的电话号码，链接，邮箱
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.allowsInlineMediaPlayback = YES;  //inline
    self.webView.mediaPlaybackRequiresUserAction = NO;
    self.webView.scrollView.bounces = NO;
    if ([self.urlString isKindOfClass:[NSString class]]&&self.urlString.length) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (webView.isLoading) {  //异步请求或者重定向过滤
        return;
    }
    self.context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = [self.context evaluateScript:@"document.title"];
    self.title = value.toString;
}

@end
