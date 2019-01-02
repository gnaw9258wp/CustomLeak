//
//  ViewController.m
//  CustomLeakTest
//
//  Created by wp on 2019/1/2.
//  Copyright © 2019年 wp. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *test = [[TestViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}
@end
