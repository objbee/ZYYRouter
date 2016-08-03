# ZYYRouter

![Pod Version](https://img.shields.io/cocoapods/v/ZYYRouter.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/ZYYRouter.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/ZYYRouter.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A navigation router for iOS.

## Installation

### From CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like ZYYRouter in your projects. First, add the following line to your Podfile:

```
pod 'ZYYRouter'
```

If you want to use the latest features of ZYYRouter use normal external source dependencies.

```
pod 'ZYYRouter', :git => 'https://github.com/idevzhou/ZYYRouter.git'
```

### Manually

Drag the `ZYYRouter/ZYYRouter/ZYYRouter` folder into your project.

## Usage

```
+ (instancetype)sharedRouter;
- (UIViewController *)currentViewController;
- (UINavigationController *)currentNavigationController;
- (void)setRootViewControllerWithClassName:(NSString *)className;
- (void)showViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters;
- (void)showViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated;
- (void)presentViewControllerWithClassName:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated;
- (void)backToViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters;
- (void)backToViewController:(NSString *)viewControllerName parameters:(NSDictionary *)parameters animated:(BOOL)animated;
- (void)popViewController;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewController;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
```


