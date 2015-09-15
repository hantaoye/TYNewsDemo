//
//  ViewController.m
//  TYNewsDemo
//
//  Created by Mac on 15/9/15.
//  Copyright (c) 2015年 TY. All rights reserved.
//

#import "ViewController.h"
#import "TYNewsView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TYNewsView *newsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_newsView setNewsImageName:@"loudspeaker"];
    [_newsView setNewArray:@[@"你好啊，亲爱的", @"你好啊发动机撒房间里的撒放大发大水放得开粮食局发生了放大时考虑范德萨离开飞", @"爱你哦", @"。。。。。。。", @"这只是个Demo"] clickAction:^(NSInteger index) {
        NSLog(@"点击了%ld", (long)index);
    }];
    [_newsView setNewsFont:[UIFont systemFontOfSize:18]];
    [_newsView setNewsTextColor:[UIColor blackColor]];
    [_newsView setAnimationTimerInterval:2];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_newsView startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_newsView stopAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
