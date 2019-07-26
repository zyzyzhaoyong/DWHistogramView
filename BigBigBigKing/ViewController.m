//
//  ViewController.m
//  BigBigBigKing
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 QIaobuyong. All rights reserved.
//

#import "ViewController.h"
#import "DWHistogramView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"柱状图" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}
- (void)action{
    NSArray *titleArray = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8"];
    DWHistogramView *dwView = [[DWHistogramView alloc]initWithModelArray:titleArray];
    dwView.intervalHeight = 80;
    dwView.frame = CGRectMake(10, 50, 350, 500);
    [self.view addSubview:dwView];
}

@end
