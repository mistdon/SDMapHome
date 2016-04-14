//
//  SDLoginViewController.m
//  SDMapHome
//
//  Created by shendong on 16/4/14.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDLoginViewController.h"

@interface SDLoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *signInButton;
@property (nonatomic,assign) BOOL signedIn;

@end

@implementation SDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSignal *userSignal = [self.accountTextField rac_textSignal];
    [userSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    RACSignal *signInSignal = [self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [signInSignal subscribeNext:^(id x) {
        NSLog(@"click");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
