//
//  APIServiceSource.m
//  PGDebugTools
//
//  Created by 张正超 on 16/4/20.
//  Copyright © 2016年 jiuxian.com. All rights reserved.
//

#import "APIServiceSource.h"
#import <JXAppConfigSurport.h>
@implementation APIServiceSource

- (NSArray *)APIServiceSource{
    return  @[[[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_developer],
              [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_qa],
              [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_GRAY],
              [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_ONLINE],
              [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_TEST],
              [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_reserve],
              ];
}

@end
