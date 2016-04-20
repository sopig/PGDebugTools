//
//  ViewController.m
//  PGDebugTools
//
//  Created by 张正超 on 16/4/19.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import "ViewController.h"
#import "DebugToolsViewController.h"
@interface ViewController (){
    UINavigationController *nav ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    nav = [UINavigationController new];
    
}


- (IBAction)action:(id)sender {
    
    DebugToolsViewController *vc = [DebugToolsViewController new];
//    [nav pushViewController:vc animated:YES];

    [self presentViewController:vc animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
