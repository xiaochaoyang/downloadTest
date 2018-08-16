//
//  ViewController.m
//  downloadTest
//
//  Created by 肖朝阳 on 2018/7/28.
//  Copyright © 2018年 肖朝阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startDownload:(id)sender {
}

#pragma mark downloadTaskDelegate

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self.CCLessonFilePath]) {
        [manager removeItemAtPath:self.CCLessonFilePath error:nil];
    }
    [manager moveItemAtPath:[location path] toPath:self.CCLessonFilePath error:&error];
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    self.currentLength =totalBytesWritten;
    [self downloadingWithProgress:((float)totalBytesWritten/totalBytesExpectedToWrite)];
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    
    if (error) {
        if ([error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData]) {
            NSData *resumeData = [error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData];
            [[NSUserDefaults standardUserDefaults] setValue:resumeData forKey:self.recordId];
        }
    } else {
        [session finishTasksAndInvalidate];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.recordId];
    }
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    if (self.backgroundDownloadFinishBlock)
        self.backgroundDownloadFinishBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
