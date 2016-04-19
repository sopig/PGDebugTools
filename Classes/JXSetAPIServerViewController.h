//
//  JXSetAPIServerViewController.h
//  jiuxian
//
//  Created by 张正超 on 15/12/4.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DebugTool.h"

@interface JXSetAPIServerViewController :UIViewController

@property(nonatomic, strong) NSObject <APIServiceSource> *source;

@end
