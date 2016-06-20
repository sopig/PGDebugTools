//
//  DebugDataManage.m
//  jiuxian
//
//  Created by 张正超 on 15/12/3.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import "DebugDataManage.h"
#import "DebugConsole.h"
#import "JXSetAPIServerViewController.h"
#import "APIServiceSource.h"
#import "DataManagerSource.h"
#import "FLEXManager.h"
#import "TestCodingVC.h"

@interface DebugDataManage ()

@end

@implementation DebugDataManage

+ (instancetype)manage {
    static DebugDataManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[self class] new];
    });
    return manage;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *idf = @"com.debugManage.idf";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
    cell.textLabel.text = [[self.source dataManagerSource] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;

    if (row == 0) {
        [self.vc dismissViewControllerAnimated:NO completion:nil];
    } else if (row == 1) {

        JXSetAPIServerViewController *vc = [JXSetAPIServerViewController new];
        vc.source = [APIServiceSource new];
        
        [self.vc presentViewController:vc animated:NO completion:nil];

    } else if (row == 2) {
        [DebugConsole startService];
        [[DebugConsole sharedInstance] showConsole];
       
    } else if (row == 3) {
        NSArray *arr = @[@"a", @"b"];
        NSLog(@"exception point = %@", arr[3]);
    } else if (row == 4) {

        Class  cls = NSClassFromString(@"NEHTTPEyeViewController");
        if (cls) {
            [self.vc presentViewController:[cls new] animated:NO completion:nil];
        }
        
    } else if (row == 5){
        
            [[FLEXManager sharedManager] showExplorer];
            [self.vc dismissViewControllerAnimated:YES completion:nil];
        
    }else if (row==6){
        TestCodingVC *vc = [[TestCodingVC alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.vc presentViewController:nvc animated:NO completion:^{
            
        }];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source dataManagerSource].count;
}

@end
