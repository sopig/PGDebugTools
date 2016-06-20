//
//  WebViewTestVC.h
//  PGDebugTools
//
//  Created by 万昌军 on 16/6/18.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewTestDisplayVC : UIViewController

@property (strong, nonatomic, nullable) UIWebView *webView;
@property (strong, nonatomic, nullable) NSString *urlString;
@property(nonatomic, nonnull, strong) JSContext *context;

@end
