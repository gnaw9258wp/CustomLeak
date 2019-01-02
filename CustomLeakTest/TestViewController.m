//
//  TestViewController.m
//  CustomLekTest
//
//  Created by wp on 2019/1/2.
//  Copyright © 2019年 wp. All rights reserved.
//

#import "TestViewController.h"
typedef void(^block)(void);
@interface TestViewController ()
@property (nonatomic,copy)block block;
@property (nonatomic,strong)NSString *str;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.str = @"123";
    self.block = ^{
        NSLog(@"%@",self.str);
    };
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
