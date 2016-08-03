//
//  ZYYViewController1.m
//  ZYYRouter
//
//  Created by yuanye on 16/8/3.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ZYYViewController1.h"

@interface ZYYViewController1 ()

@end

@implementation ZYYViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", self.string);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title {
    return NSStringFromClass([self class]);
}

@end
