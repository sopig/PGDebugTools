//
//  WKWebViewTestDisplayVC.m
//  PGDebugTools
//
//  Created by 万昌军 on 16/6/22.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import "WKWebViewTestDisplayVC.h"

@interface WKWebViewTestDisplayVC ()<WKUIDelegate>



@end

@implementation WKWebViewTestDisplayVC

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;  //inline
    config.requiresUserActionForMediaPlayback = NO;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) configuration:config];
    [self.view addSubview:_webView];
    _webView.UIDelegate = self;
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.bounces = NO;
    if ([self.urlString isKindOfClass:[NSString class]]&&self.urlString.length) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView) {
            self.title = self.webView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end

