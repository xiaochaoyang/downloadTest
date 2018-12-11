//
//  ViewController.m
//  downloadTest
//
//  Created by 肖朝阳 on 2018/7/28.
//  Copyright © 2018年 肖朝阳. All rights reserved.
//

#import "ViewController.h"
#import <CCSDK/RequestData.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber *num = @1;
    
    RequestData *data = [[RequestData alloc] initWithParameter:[PlayParameter new]];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startDownload:(id)sender {
}

#pragma mark downloadTaskDelegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
