//
//  YQOnlineRequestManager.m
//  LogicProcessorSDK
//
//  Created by 张森 on 2017/10/23.
//  Copyright © 2017年 __YiQiSchool__. All rights reserved.
//

#import "YQOnlineRequestManager.h"
#import "YQOnlineNetworkInterface.h"

@interface YQOnlineRequestManager ()

@end

@implementation YQOnlineRequestManager

+ (YQOnlineNetworkConnector *)sharedConnector {
    static YQOnlineNetworkConnector *connector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connector = [[YQOnlineNetworkConnector alloc] initWithBaseURL:[NSURL URLWithString:@"http://test.17kaojiaoshi.com:3088"]];
        connector.requestSerializer = [YQOnlineNetworkRequestSerializer serializer];
        connector.responseSerializer = [YQOnlineNetworkResponseSerializer serializer];
    });
    return connector;
}

+ (void)sendAsynPostRequestWithAPIHostPath:(NSString *)apiHostPath withRequestContent:(NSDictionary *)requestContent success:(void (^)(id encryptedResponseContent))successResponse failure:(void (^)(NSError * error))failureResponse {
    [[YQOnlineRequestManager sharedConnector] POST:apiHostPath parameters:requestContent progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successResponse(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureResponse(error);
    }];
}

+ (void)sendSyncHeadRequestWithURL:(NSString *)url success:(void (^)(NSDictionary *responseHeaderFields))successResponse failure:(void (^)(NSError * error))failureResponse {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"HEAD"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (urlResponse && !error)
        successResponse([urlResponse allHeaderFields]);
    else
        failureResponse(error);
}

+ (void)sendAsynGetRequestWithURL:(NSString *)url success:(void (^)(id responseContent))successResponse failure:(void (^)(NSError * error))failureResponse {
    [[YQOnlineRequestManager sharedConnector] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successResponse)
            successResponse(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureResponse)
            failureResponse(error);
    }];
}

+ (void)sendAsynHeadRequestWithURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *dataTask))successResponse failure:(void (^)(NSError * error))failureResponse {
    [[YQOnlineRequestManager sharedConnector] HEAD:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task) {
        if (successResponse)
            successResponse(task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureResponse) {
            failureResponse(error);
        }
    }];
}

@end
