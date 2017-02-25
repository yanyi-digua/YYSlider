//
//  ViewController.m
//  YYSlider
//
//  Created by 如步 on 2017/2/22.
//  Copyright © 2017年 如步. All rights reserved.
//

#import "ViewController.h"
#import "YYScrollViewVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadSubView];
}

- (void)loadSubView
{
    self.title = @"首页";
    self.titleArr = [[NSMutableArray alloc]initWithObjects:@"全部\n5",@"待接单\n2",@"待预约\n3",@"待签到\n4",@"待完工\n5", nil];
    //self.titleArr = [[NSMutableArray alloc]initWithObjects:@"全部任务",@"今日任务", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"进入下一页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}
- (void)btnClick:(UIButton *)sender {
    YYScrollViewVC *vc = [[YYScrollViewVC alloc]initWithAdvertArr:self.titleArr passType:0];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
