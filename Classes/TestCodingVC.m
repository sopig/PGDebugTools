//
//  TestCodingVC.m
//  PGDebugTools
//
//  Created by 张正超 on 16/4/20.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import "TestCodingVC.h"
#import "WebViewTestVC.h"
//#import "WKWebViewTestVC.h"

@interface TestCodingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic, nullable) UITableView *tableView;

@end

@implementation TestCodingVC

#pragma mark -LfeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"测试功能";
    [self initTableView];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Inits

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.rowHeight = 40;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.dataSource = self;
}

#pragma mark -UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.textLabel.text = @"WebView测试";
    }else if (indexPath.row==1){
        cell.textLabel.text = @"WKWebView测试";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            WebViewTestVC *vc = [[WebViewTestVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//            WKWebViewTestVC *vc = [[WKWebViewTestVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
}

#pragma mark -Events

- (void)handleLeftButtonClick:(UIButton *)button{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
