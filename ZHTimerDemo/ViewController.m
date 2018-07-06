//
//  ViewController.m
//  ZHTimerDemo
//
//  Created by howie on 29/03/2017.
//  Copyright © 2017 Realtime. All rights reserved.
//

#import "ViewController.h"
#import "ZHTimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 40);
    button.center = self.view.center;
    
    [button setTitle:@"timer" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blueColor];
    [button addTarget:self action:@selector(gotoTimerVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.title = @"ViewController";
}

- (void)gotoTimerVC {
    ZHTimerViewController *vc = [[ZHTimerViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
