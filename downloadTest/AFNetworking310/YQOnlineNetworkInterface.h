//
//  YQOnlineNetworkInterface.h
//  LogicProcessorSDK
//
//  Created by 张森 on 2017/10/21.
//  Copyright © 2017年 __YiQiSchool__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"

@interface YQOnlineNetworkConnector : AFHTTPSessionManager
@end

@interface YQOnlineNetworkRequestSerializer : AFJSONRequestSerializer
@end

@interface YQOnlineNetworkResponseSerializer : AFJSONResponseSerializer
@end

@interface YQOnlineNetWorkReachabilityManager : AFNetworkReachabilityManager

@property (nonatomic, assign, readonly) BOOL networkIsAvailable;

@end
