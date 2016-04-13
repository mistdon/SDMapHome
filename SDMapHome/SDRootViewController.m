//
//  SDRootViewController.m
//  SDMapHome
//
//  Created by shendong on 16/4/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDRootViewController.h"
#import "SDMapViewController.h"
#import "JPTableViewController.h"
#import "SDMapChoiceView.h"

static NSString *const menuCellIdentifier = @"menuCellIdentifier";

@interface SDRootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation SDRootViewController{
    NSArray *source;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SD Map";
    source = @[@"Map",@"JSPatch"];
    [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:menuCellIdentifier];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  source.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier];
    cell.textLabel.text = source[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SDMapViewController *map = [SDMapViewController new];
        map.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:map animated:YES];
    }else if (indexPath.row == 1){
        JPTableViewController *jp = [[JPTableViewController alloc] init];
        [self.navigationController pushViewController:jp animated:YES];
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
