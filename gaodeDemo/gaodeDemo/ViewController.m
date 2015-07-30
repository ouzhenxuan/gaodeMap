//
//  ViewController.m
//  gaodeDemo
//
//  Created by ozx on 15/7/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "ViewController.h"
#import "mapViewController.h"
#import "testViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn =  [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 20, 20);
    [btn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton * btn1 =  [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn1];
    btn1.frame = CGRectMake(100, 200, 20, 20);
    [btn1 addTarget:self action:@selector(startLocationAgain) forControlEvents:UIControlEventTouchDown];
    
    

}

- (void)startLocation{
    mapViewController * mapVc = [[mapViewController alloc] init];
    [self.navigationController pushViewController:mapVc animated:YES];
}

- (void)startLocationAgain{
    testViewController * mapVc = [[testViewController alloc] init];
    [self.navigationController pushViewController:mapVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
