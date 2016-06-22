//
//  WKWebViewTestVC.m
//  PGDebugTools
//
//  Created by 万昌军 on 16/6/22.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import "WKWebViewTestVC.h"
#import "WKWebViewTestDisplayVC.h"

@interface WKWebViewTestVC ()<UITextViewDelegate>

@property (strong, nonatomic, nullable) UITextView *textView;

@end

@implementation WKWebViewTestVC

#pragma mark -LfeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initTextView];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Inits

- (void)initTextView{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20+60, [UIScreen mainScreen].bounds.size.width-40, 100)];
    _textView.scrollsToTop = NO;
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:24];
    _textView.textColor = [UIColor blackColor];
    _textView.returnKeyType = UIReturnKeyGo;
    _textView.layer.cornerRadius = 3;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor redColor].CGColor;
    _textView.textContainer.lineBreakMode = NSLineBreakByCharWrapping;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.layer.masksToBounds = YES;
    [self.view addSubview:_textView];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clearButton.frame = CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y+_textView.frame.size.height+20, _textView.frame.size.width/2.0-10, 40);
    [clearButton addTarget:self action:@selector(handleClearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setTitle:@"清除缓存" forState:UIControlStateNormal];
    [self.view addSubview:clearButton];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    testButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2.0+10, _textView.frame.origin.y+_textView.frame.size.height+20, _textView.frame.size.width/2.0-10, 40);
    [testButton setTitle:@"确定" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(handleTestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}

#pragma mark -UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self.view endEditing:YES];
        WKWebViewTestDisplayVC *vc = [[WKWebViewTestDisplayVC alloc] init];
        vc.urlString = textView.text;
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    return YES;
}

#pragma mark -Events

- (void)handleClearButtonClick:(UIButton *)button{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (void)handleTestButtonClick:(UIButton *)button{
    [self.view endEditing:YES];
    WKWebViewTestDisplayVC *vc = [[WKWebViewTestDisplayVC alloc] init];
    vc.urlString = _textView.text;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
