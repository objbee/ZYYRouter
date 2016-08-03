//
//  ZYYViewController3.m
//  ZYYRouter
//
//  Created by yuanye on 16/8/4.
//  Copyright © 2016年 yuanye. All rights reserved.
//  

#import "ZYYViewController3.h"
#import "ZYYRouter.h"

@interface ZYYViewController3 ()

@end

@implementation ZYYViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[ZYYRouter sharedRouter] popViewController];
}

- (NSString *)title {
    return NSStringFromClass([self class]);
}

@end
