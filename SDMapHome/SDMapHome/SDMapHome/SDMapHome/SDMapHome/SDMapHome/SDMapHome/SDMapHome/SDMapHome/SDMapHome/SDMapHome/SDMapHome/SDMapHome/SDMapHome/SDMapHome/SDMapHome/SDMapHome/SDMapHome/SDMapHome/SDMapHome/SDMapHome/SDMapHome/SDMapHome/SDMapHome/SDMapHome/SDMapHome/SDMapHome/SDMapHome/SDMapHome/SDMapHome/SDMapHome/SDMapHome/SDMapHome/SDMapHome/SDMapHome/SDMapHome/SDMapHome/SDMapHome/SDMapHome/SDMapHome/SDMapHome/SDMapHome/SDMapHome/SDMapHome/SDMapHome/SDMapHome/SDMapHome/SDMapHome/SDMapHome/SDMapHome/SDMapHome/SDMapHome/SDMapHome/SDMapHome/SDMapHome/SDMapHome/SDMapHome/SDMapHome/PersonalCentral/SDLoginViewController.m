//
//  SDLoginViewController.m
//  SDMapHome
//
//  Created by shendong on 16/4/14.
//  Copyright © 2016年 Allen. All rights reserved.
//
/*
 RACSignal的每一个操纵都会返回一个RACSignal，这个在术语上叫做连贯接口，这个功能可以让你直接构造管道，而不用每一步都使用本地变量
 
 
 
 */
#import "SDLoginViewController.h"
#import "SDLoginViewModel.h"


@interface SDLoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *signInButton;
@property (nonatomic,assign) BOOL signedIn;
@property (nonatomic, strong) SDLoginViewModel *viewModel;

@end

@implementation SDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindModel];
}

- (void)bindModel{
    self.viewModel = [[SDLoginViewModel alloc] init];
    RAC(self.viewModel, account)  = self.accountTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.signInButton, enabled) = [self.viewModel signInButtonValid];
    @weakify(self);
    
    RAC(self.accountTextField, backgroundColor) = [self.accountTextField.rac_textSignal map:^id(NSString *value) {
        return value.length < 6 ? [UIColor yellowColor] : [UIColor clearColor];
    }];
    RAC(self.passwordTextField, backgroundColor) = [self.passwordTextField.rac_textSignal map:^id(NSString *value) {
        return value.length < 6 ? [UIColor yellowColor] : [UIColor clearColor];
    }];
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        @strongify(self)
        self.signInButton.enabled = NO;
        //show hud
        [SVProgressHUD showWithStatus:@"Sign in ...."];
    }]
    flattenMap:^RACStream *(id value) {
        return [self.viewModel signInSignal];
    }]
    subscribeNext:^(NSNumber *signedIn) {
        @strongify(self);
        self.signInButton.enabled = YES;
        if ([signedIn boolValue]) {
            //do the next
            [SVProgressHUD showWithStatus:@"Success"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
                [standard setBool:YES forKey:SDUserLogedIn];
                [standard synchronize];
                [self dismissViewControllerAnimated:YES completion:NULL];
            });
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
