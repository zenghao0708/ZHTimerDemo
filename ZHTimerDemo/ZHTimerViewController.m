//
//  ZHTimerViewController.m
//  ZHTimerDemo
//
//  Created by howie on 29/03/2017.
//  Copyright © 2017 Realtime. All rights reserved.
//

#import "ZHTimerViewController.h"

@interface ZHTimerViewController ()
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZHTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // CASE1 - 这样的用法会导致内存泄露： self 和 timer之间相互引用，导致无法释放，dealloc 方法不会得到释放
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timeout)
                                                userInfo:nil
                                                 repeats:YES];
    
    // CASE2 - iOS 10 新 API，可以解决循环引用的问题
//    __weak __typeof(&*self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                                 repeats:YES
//                                                   block:^(NSTimer * _Nonnull timer) {
//        [weakSelf timeout];
//    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 40);
    button.center = self.view.center;
    
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blueColor];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)dealloc {
    NSLog(@"dealloc");
    [self stopTimerIfNeeded];
}

- (void)stopTimerIfNeeded {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"invalide timer");
    }
}

- (void)timeout {
    NSLog(@"timeout");
}

- (void)dismiss {
    // CASE1 - 在 dismiss 的completion 中来停掉 timer
    __weak __typeof(&*self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf stopTimerIfNeeded];
    }];
    
    // CASE2 - 直接 dismiss，block 中会做 timer 的释放
//    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
