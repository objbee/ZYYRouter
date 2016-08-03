//
//  ZYYViewController2.m
//  ZYYRouter
//
//  Created by yuanye on 16/8/3.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ZYYViewController2.h"

@interface ZYYViewController2 ()

@end

@implementation ZYYViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", self.array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title {
    return NSStringFromClass([self class]);
}

@end
