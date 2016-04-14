//
//  SDRootViewController.m
//  SDMapHome
//
//  Created by shendong on 16/4/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDRootViewController.h"
#import "SDFileToolClass.h"
#import <objc/runtime.h>

static NSString *const menuCellIdentifier = @"menuCellIdentifier";

@interface SDRootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *source;

@end

@implementation SDRootViewController{
    BOOL needCheckSignInStatus;
}

#pragma mark - lazy loading
- (NSMutableArray *)source{
    if (!_source) {
        _source = [@[] mutableCopy];
    }
    return _source;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"默默Desire";
    //1. get source class
    NSArray *array = [SDFileToolClass sd_getRootClasses];
    [self.source addObjectsFromArray:array];
    //2. set UI
    [self setupUI];
    //3.check out sign status
    needCheckSignInStatus = NO;
    
    NSArray *array1 = [SDFileToolClass sd_getCrashLogs];
    NSLog(@"count = %ld",array1.count);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!needCheckSignInStatus) return;
    UIViewController *signInVC = (UIViewController *)[[NSClassFromString(@"SDLoginViewController") alloc] init];
    [self presentViewController:signInVC animated:YES completion:NULL];
}
#pragma mark - setupUI

- (void)setupUI{
    [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:menuCellIdentifier];
     self.menuTableView.tableFooterView = [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.source.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier];
    NSDictionary *dict = self.source[indexPath.row];
    cell.textLabel.text = dict[@"class_functionName"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.source[indexPath.row];
    NSString *destVC = [dict objectForKey:@"class_destinationViewController"];
    if (destVC.length < 1) return;  //当目标ViewController为空时,返回
    Class class                       = NSClassFromString(destVC);
    UIViewController *instance        = [[class alloc] init];
    instance.title                    = dict[@"class_functionName"];
    instance.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:instance animated:YES];
}

@end
