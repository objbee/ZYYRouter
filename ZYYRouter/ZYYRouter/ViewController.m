//
//  ViewController.m
//  ZYYRouter
//
//  Created by yuanye on 16/8/3.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ViewController.h"
#import "ZYYRouter.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    NSLog(@"%@", [[ZYYRouter sharedRouter] currentViewController]);
    NSLog(@"%@", [[ZYYRouter sharedRouter] currentNavigationController]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"ZYYViewController%@", @(indexPath.row + 1)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = [NSString stringWithFormat:@"ZYYViewController%@", @(indexPath.row + 1)];
    if (indexPath.row == 0) {
        [[ZYYRouter sharedRouter] showViewController:className parameters:@{@"string":@"zyy"}];
    } else if (indexPath.row == 1) {
        [[ZYYRouter sharedRouter] showViewController:className parameters:@{@"array":@[@"z", @"y", @"y"]}];
    } else if (indexPath.row == 2) {
        [[ZYYRouter sharedRouter] presentViewControllerWithClassName:className parameters:nil animated:YES];
    }
}

- (NSString *)title {
    return NSStringFromClass([self class]);
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    }
    return _tableView;
}

@end
