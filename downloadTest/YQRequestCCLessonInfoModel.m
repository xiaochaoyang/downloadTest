//
//  YQRequestCCLessonInfoModel.m
//  ExtensibleServiceSDK
//
//  Created by 肖朝阳 on 2018/7/27.
//  Copyright © 2018年 __YiQiSchool__. All rights reserved.
//

#import "YQRequestCCLessonInfoModel.h"
#import "YQOnlineRequestManager.h"
#import <CommonCrypto/CommonDigest.h>

@interface YQRequestCCLessonInfoModel ()

@property (nonatomic, strong) dispatch_block_t success;
@property (nonatomic, strong) NSURLSessionDataTask *requestLessonUrlTask;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *userAcount;
@property (nonatomic, strong) NSString *CCAPIKey;
@property (nonatomic, strong, readwrite) NSString *downloadUrl;
@property (nonatomic, strong, readwrite) NSNumber *startTime;

@end

@implementation YQRequestCCLessonInfoModel

- (void)requestCCLessonLessonInfoWithRecordId:(NSString *)recordId Success:(dispatch_block_t)successResponse Failure:(void (^)(NSError *))failureResponse {
    NSString *domainString = @"http://api.csslcloud.net/api/v2/record/search?";
    NSString *queryString = [NSString stringWithFormat:@"recordid=%@&userid=%@",recordId,self.userAcount];
    long nowInterval = (long)[[NSDate date] timeIntervalSince1970];
    NSString *needEncryptString = [NSString stringWithFormat:@"%@&time=%ld&salt=%@",queryString,nowInterval,self.CCAPIKey];
    NSString *encryptedString = [YQRequestCCLessonInfoModel MD5ForUpper32Bate:needEncryptString];//[CCLiveUtil MD5String:needEncryptString andUpper:YES];
    queryString = [NSString stringWithFormat:@"%@&time=%ld&hash=%@",queryString,nowInterval,encryptedString];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",domainString,queryString];
    [YQOnlineRequestManager sendAsynGetRequestWithURL:urlString success:^(NSDictionary *responseContent) {
        if ([responseContent isKindOfClass:[NSDictionary class]]) {
            NSDictionary *result = (NSDictionary *)responseContent;
            NSDictionary *recordDict = [result valueForKey:@"record"];
            self.downloadUrl = [recordDict valueForKey:@"downloadUrl"];
            NSString *startTimeString = [recordDict valueForKey:@"startTime"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *date = [formatter dateFromString:startTimeString];
            NSTimeInterval startInterval = [date timeIntervalSince1970];
            self.startTime = [NSNumber numberWithDouble:startInterval];
            if (successResponse) {
                successResponse();
            }
        } else {
            NSError *error = [NSError errorWithDomain:@"request fail" code:1000 userInfo:@{NSLocalizedDescriptionKey:@"请求失败"}];
            if (failureResponse)
                failureResponse(error);
        }
    } failure:failureResponse];
}

- (NSString *)userAcount {
    if (!_userAcount) {
        _userAcount = @"5BCF78B684FABB64";
    }
    return _userAcount;
}

- (NSString *)CCAPIKey {
    if (!_CCAPIKey) {
        _CCAPIKey = @"MT9DEgWUgwIxH4n3mU5krAlkc8wdYPe6";
    }
    return _CCAPIKey;
}
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

@end
