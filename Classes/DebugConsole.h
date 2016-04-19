//
//  DebugConsole.h
//  jiuxian
//
//  Created by 张正超 on 15/12/4.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DebugConsole : NSObject

+ (id)sharedInstance;

+ (void)startService;

- (void)showConsole;

- (void)hideConsole;


@end
