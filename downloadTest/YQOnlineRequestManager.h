//
//  YQOnlineRequestManager.h
//  LogicProcessorSDK
//
//  Created by 张森 on 2017/10/23.
//  Copyright © 2017年 __YiQiSchool__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQOnlineRequestManager : NSObject

+ (void)sendAsynPostRequestWithAPIHostPath:(NSString *)apiHostPath withRequestContent:(NSDictionary *)requestContent success:(void (^)(id encryptedResponseContent))successResponse failure:(void (^)(NSError * error))failureResponse;

+ (void)sendSyncHeadRequestWithURL:(NSString *)url success:(void (^)(NSDictionary *responseHeaderFields))successResponse failure:(void (^)(NSError * error))failureResponse;

+ (void)sendAsynGetRequestWithURL:(NSString *)url success:(void (^)(id responseContent))successResponse failure:(void (^)(NSError * error))failureResponse;

+ (void)sendAsynHeadRequestWithURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *dataTask))successResponse failure:(void (^)(NSError * error))failureResponse;

@end
