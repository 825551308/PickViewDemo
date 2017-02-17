//
//  ViewController.m
//  PickViewDemo
//
//  Created by 金汕汕 on 16/12/3.
//  Copyright © 2016年 ccs. All rights reserved.
//

#import "ViewController.h"
#import "MPPickView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MPPickView *mp = [MPPickView  instanceMPPickView];
    mp.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 150);
    NSArray *areaArray = @[@"台州",@"杭州",@"温州",@"苏州",@"泰州"];
    NSArray *dataArray = @[@"11",@"22",@"33",@"44",@"55"];
    NSArray *dataArray2 = @[@"11$",@"22$",@"33$",@"44$",@"55$"];
    
    [mp createView:[@[areaArray,dataArray,dataArray2] mutableCopy] ];
    mp.returnTextBlock = ^(NSString *showText){
        NSLog(@"选中了:%@",showText);
    };
    mp.returnArrayBlock = ^(NSArray *showArray){
        NSLog(@"array选中了:%@",showArray);
    };
    
    [self.view addSubview:mp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
