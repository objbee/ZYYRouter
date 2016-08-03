//
//  ZYYRouter.m
//  ZYYRouter
//
//  Created by yuanye on 16/7/30.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ZYYRouter.h"

@implementation ZYYRouter
+ (instancetype)sharedRouter {
    static ZYYRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!router) {
            router = [[self alloc] init];
        }
    });
    return router;
}

#pragma mark- public

- (void)setRootViewControllerWithClassName:(NSString *)className {
    UIViewController *viewController = [self getViewControllerWithClassName:className];
    if (viewController) {
        self.rootViewController = viewController;
    } else {
        [NSException raise:@"the name of the class does not exist" format:@"class name [%@]",className];
    }
}

- (UINavigationController *)currentNavigationController {
    UINavigationController *navigationController = [[self class] expectedVisibleNavigationController];
    return navigationController;
}

- (UIViewController *)currentViewController {
    return [[self class] visibleViewControllerWithRootViewController:self.rootViewController];
}

- (void)showViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters {
    [self showViewController:viewControllerName parameters:parameters animated:YES];
}

- (void)showViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated {
    UINavigationController *navigationController = [[self class] expectedVisibleNavigationController];
    UIViewController *viewController = [self getViewControllerWithClassName:viewControllerName];
    if (viewController) {
        if (navigationController) {
            [self pushViewController:viewController parameters:parameters navigationController:navigationController animated:animated];
        } else {
            [self presentViewController:viewController parameters:parameters animated:animated];
        }
    }
}

- (void)presentViewControllerWithClassName:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated {
    UIViewController *viewController = [self getViewControllerWithClassName:viewControllerName];
    if (viewController) {
        [self presentViewController:viewController parameters:parameters animated:animated];
    }
}

- (void)backToViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters {
    [self backToViewController:viewControllerName parameters:parameters animated:YES];
}

- (void)backToViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated {
    UINavigationController *navigationController = self.currentNavigationController;
    if (navigationController && navigationController.viewControllers.count > 1) {
        UIViewController *targetViewController = nil;
        for (NSInteger i = navigationController.viewControllers.count - 2; i >= 0; i --) {
            UIViewController *viewController = [navigationController.viewControllers objectAtIndex:i];
            NSString *className = NSStringFromClass([viewController class]);
            if ([className isEqualToString:viewControllerName]) {
                targetViewController = viewController;
                break;
            }
        }
        if (targetViewController) {
            [self mapViewController:targetViewController parameters:parameters];
            [navigationController popToViewController:targetViewController animated:animated];
        } else {
            [NSException raise:@"not found target viewcontroller" format:@"class name [%@]",viewControllerName];
        }
    } else {
        UIViewController *currentViewController = [self currentViewController];
        NSLog(@"%@",currentViewController.presentingViewController);
    }
}

- (void)popViewController {
    [self popViewControllerAnimated:YES];
}

- (void)popViewControllerAnimated:(BOOL)animated {
    UIViewController *currentViewController = [self currentViewController];
    if (currentViewController.presentingViewController) {
        [currentViewController dismissViewControllerAnimated:animated completion:^{}];
    } else {
        [currentViewController.navigationController popViewControllerAnimated:animated];
    }
}

- (void)popToRootViewController {
    [self popToRootViewControllerAnimated:YES];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    UIViewController *currentViewController = [self currentViewController];
    if (currentViewController.presentingViewController) {
        [currentViewController dismissViewControllerAnimated:animated completion:^{}];
    } else {
        [currentViewController.navigationController popToRootViewControllerAnimated:animated];
    }
}

- (id)getViewControllerWithClassName:(NSString *)className {
    UIViewController *viewController = nil;
    if (className) {
        viewController = [[NSClassFromString(className) alloc] init];
    }
    return viewController;
}

#pragma mark - private

- (void)pushViewController:(UIViewController *)viewController parameters:(NSDictionary *)parameters navigationController:(UINavigationController *)navigationController animated:(BOOL)animated {
    if (!viewController || [viewController isKindOfClass:[UINavigationController class]] || !navigationController) {
        return;
    }
    [self mapViewController:viewController parameters:parameters];
    [viewController setHidesBottomBarWhenPushed:YES];
    [navigationController pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewController parameters:(NSDictionary *)parameters animated:(BOOL)animated {
    if (!viewController) {
        return;
    }
    [self mapViewController:viewController parameters:parameters];
    UIViewController *vc = [[self class] visibleViewControllerWithRootViewController:[[self class] visibleViewController]];
    [vc presentViewController:viewController animated:animated completion:^{}];
}

- (void)mapViewController:(UIViewController *)viewController parameters:(NSDictionary *)parameters {
    if (!viewController || [viewController isKindOfClass:[UINavigationController class]]) {
        return;
    }
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // TODO: 安全性检测
        [viewController setValue:obj forKey:key];
    }];
}

+ (UINavigationController *)expectedVisibleNavigationController {
    UIViewController *viewController = [self visibleViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    UINavigationController *navigationController = (UINavigationController *)([viewController isKindOfClass:[UINavigationController class]] ? viewController : viewController.navigationController);
    return navigationController;
}

+ (UIViewController *)visibleViewController {
    UIViewController *viewController = [self visibleViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    return viewController;
}

+ (UIViewController *)visibleViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self visibleViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self visibleViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self visibleViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma mark - setter and getter

- (void)setRootViewController:(UIViewController *)rootViewController {
    [UIApplication sharedApplication].delegate.window.rootViewController = rootViewController;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

- (UIViewController *)rootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

@end
