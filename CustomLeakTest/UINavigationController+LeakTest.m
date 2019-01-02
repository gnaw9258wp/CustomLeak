//
//  UINavigationController+LeakTest.m
//  CustomLekTest
//
//  Created by wp on 2019/1/2.
//  Copyright © 2019年 wp. All rights reserved.
//

#import "UINavigationController+LeakTest.h"
#import <objc/runtime.h>

@implementation UINavigationController (LeakTest)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wp_swizzleOriginSEL:@selector(popViewControllerAnimated:) currentSEL:@selector(wp_popViewControllerAnimated:)];
    });
}

+ (void)wp_swizzleOriginSEL:(SEL)originSEL currentSEL:(SEL)currentSEL{
    Method originMethod  = class_getInstanceMethod([self class], originSEL);
    Method currentMethod  = class_getInstanceMethod([self class], currentSEL);
    method_exchangeImplementations(originMethod, currentMethod);
}

- (UIViewController *)wp_popViewControllerAnimated:(BOOL)animated{
    extern const char *WPVCPOPFLAG;
    UIViewController *popViewController = [self wp_popViewControllerAnimated:animated];
    objc_setAssociatedObject(popViewController, WPVCPOPFLAG, @(YES), OBJC_ASSOCIATION_ASSIGN);
    return popViewController;
}
@end
