//
//  YQOnlineNetworkInterface.m
//  LogicProcessorSDK
//
//  Created by 张森 on 2017/10/21.
//  Copyright © 2017年 __YiQiSchool__. All rights reserved.
//

#import "YQOnlineNetworkInterface.h"

@implementation YQOnlineNetworkConnector
@end

@implementation YQOnlineNetworkRequestSerializer
@end

@implementation YQOnlineNetworkResponseSerializer
@end


@implementation YQOnlineNetWorkReachabilityManager : AFNetworkReachabilityManager

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    if (self = [super initWithReachability:reachability]) {
        __block YQOnlineNetWorkReachabilityManager *blockSelf = self;
        [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    _networkIsAvailable = YES;
                    break;
                case AFNetworkReachabilityStatusUnknown:
                case AFNetworkReachabilityStatusNotReachable:
                    _networkIsAvailable = NO;
                    break;
                default:
                    break;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:blockSelf];
        }];
    }
    return self;
}

+ (instancetype)sharedManager {
    static YQOnlineNetWorkReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
        
    });
    [_sharedManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:nil];
    }];
    return _sharedManager;
}


@end
