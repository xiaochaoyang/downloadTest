//
//  YQRequestCCLessonInfoModel.h
//  ExtensibleServiceSDK
//
//  Created by 肖朝阳 on 2018/7/27.
//  Copyright © 2018年 __YiQiSchool__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQRequestCCLessonInfoModel : NSObject

@property (nonatomic, strong, readonly) NSString *downloadUrl;
@property (nonatomic, strong, readonly) NSNumber *startTime;

- (void)requestCCLessonLessonInfoWithRecordId:(NSString *)recordId Success:(dispatch_block_t)successResponse Failure:(void (^)(NSError *))failureResponse;

@end
