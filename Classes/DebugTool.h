//
//  DebugTool.h
//  jiuxian
//
//  Created by 张正超 on 16/4/19.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const _Nonnull HOSTDOMAIN ;
FOUNDATION_EXPORT NSString *const _Nonnull HostDomainChangeNotification;

@protocol APIServiceSource <NSObject>

@required
- (NSArray * _Nonnull)APIServiceSource;

@end

@protocol DebugDataManagerSource <NSObject>

@required
- (NSArray * _Nonnull)dataManagerSource;

@end


@protocol DebugTool <NSObject,APIServiceSource,DebugDataManagerSource>

@end
