//
//  UIViewController+LeaksTest.m
//  CustomLekTest
//
//  Created by wp on 2019/1/2.
//  Copyright © 2019年 wp. All rights reserved.
//

#import "UIViewController+LeaksTest.h"
#import <objc/runtime.h>

const char * WPVCPOPFLAG;

@implementation UIViewController (LeaksTest)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wp_swizzleOriginSEL:@selector(viewWillAppear:) currentSEL:@selector(wp_viewWillAppear:)];
        [self wp_swizzleOriginSEL:@selector(viewDidDisappear:) currentSEL:@selector(wp_viewDidDisappear:)];
    });
}

+ (void)wp_swizzleOriginSEL:(SEL)originSEL currentSEL:(SEL)currentSEL{
    Method originMethod  = class_getInstanceMethod([self class], originSEL);
    Method currentMethod  = class_getInstanceMethod([self class], currentSEL);
    method_exchangeImplementations(originMethod, currentMethod);
}

-(void)wp_viewWillAppear:(BOOL)animated
{
    [self wp_viewWillAppear:animated];
    objc_setAssociatedObject(self, WPVCPOPFLAG, @(NO), OBJC_ASSOCIATION_RETAIN);
}

-(void)wp_viewDidDisappear:(BOOL)animated
{
    [self wp_viewWillAppear:animated];
    
    if ([objc_getAssociatedObject(self, WPVCPOPFLAG) boolValue]) {
        //发送消息
        [self willDelloc];
    }
}

- (void)willDelloc{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf isNotDelloc];
    });
}

- (void)isNotDelloc{
    NSLog(@"%@ IS NOT DELLOC",NSStringFromClass([self class]));
}
@end
