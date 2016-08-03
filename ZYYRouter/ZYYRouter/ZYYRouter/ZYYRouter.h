//
//  ZYYRouter.h
//  ZYYRouter
//
//  Created by yuanye on 16/7/30.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYYRouter : NSObject

/**
 *  window.rootViewController
 */
@property (strong, nonatomic) UIViewController *rootViewController;

/**
 *  ZYYRouter 单例
 *
 *  @return 一个单例对象
 */
+ (instancetype)sharedRouter;

/**
 *  设置 rootViewController
 *
 *  @param className rootViewController 类名
 */
- (void)setRootViewControllerWithClassName:(NSString *)className;

/**
 *  获取当前 NavigationController
 *
 *  @return 当前 NavigationController
 */
- (UINavigationController *)currentNavigationController;

/**
 *  获取当前展示的 ViewController
 *
 *  @return 当前展示的 ViewController
 */
- (UIViewController *)currentViewController;

/**
 *  Push or Present ViewController
 *
 *  @param viewControllerName 目标 ViewController 的类名
 *  @param parameters         目标 ViewController 需要的参数
 *  @param animated           default YES
 */
- (void)showViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters;

/**
 *  Push or Present ViewController
 *
 *  @param viewControllerName 目标 ViewController 的类名
 *  @param parameters         目标 ViewController 需要的参数
 *  @param animated           是否动画
 */
- (void)showViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated;

/**
 *  Present ViewController
 *
 *  @param viewControllerName 目标 ViewController 的类名
 *  @param parameters         目标 ViewController 需要的参数
 *  @param animated           是否动画
 */
- (void)presentViewControllerWithClassName:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated;

/**
 *  返回到当前导航栈内类名为 viewControllerName 的 ViewController
 *
 *  @param viewControllerName 返回到的 ViewController 类名
 *  @param parameters         该 ViewController 回调参数
 *  @param animated           default YES
 */
- (void)backToViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters;

/**
 *  返回到当前导航栈内类名为 viewControllerName 的 ViewController
 *
 *  @param viewControllerName 返回到的 ViewController 类名
 *  @param parameters         该 ViewController 回调参数
 *  @param animated           是否动画
 */
- (void)backToViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated;

/**
 *  返回上一级页面 Pop or Dismiss
 *
 *  @param animated default YES
 */
- (void)popViewController;

/**
 *  返回上一级页面 Pop or Dismiss
 *
 *  @param animated 是否动画
 */
- (void)popViewControllerAnimated:(BOOL)animated;

/**
 *  返回根目录 Pop
 *
 *  @param animated default YES
 */
- (void)popToRootViewController;

/**
 *  返回根目录 Pop
 *
 *  @param animated 是否动画
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated;

@end
