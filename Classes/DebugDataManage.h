//
//  DebugDataManage.h
//  jiuxian
//
//  Created by 张正超 on 15/12/3.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DebugTool.h"
@interface DebugDataManage : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) __kindof UIViewController *vc;

@property (nonatomic , strong, nonnull) NSObject <DebugDataManagerSource> *source;

+ (instancetype _Nonnull)manage;


@end
