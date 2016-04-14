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

@interface SDLoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *signInButton;
@property (nonatomic,assign) BOOL signedIn;

@end

@implementation SDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[self.accountTextField rac_textSignal] filter:^BOOL(NSString *text) {
        return text.length > 3;
    }] subscribeNext:^(id x) {
        NSLog(@"x = %@",x);
    }];
    
    [[[[self.passwordTextField rac_textSignal] map:^id(NSString *value) {
        return @(value.length);
    }] filter:^BOOL(NSNumber *length) {
        return [length integerValue] > 3;
    }] subscribeNext:^(id x) {
        NSLog(@"x = %@",x);
    }];
    
    RACSignal *validAccountSignal = [[self.accountTextField rac_textSignal] map:^id(NSString *value) {
        return @([self isValidAccountName:value]);
    }];
    RACSignal *validPasswordSignal = [[self.passwordTextField rac_textSignal] map:^id(NSString *value) {
        return @([self isValidPassword:value]);
    }];
    
    RAC(self.accountTextField,backgroundColor) = [validAccountSignal map:^id(NSNumber *accountValid) {
        return [accountValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    RAC(self.passwordTextField, backgroundColor) = [validPasswordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue]?[UIColor clearColor]:[UIColor yellowColor];
    }];
    
    
    RACSignal *signInSignal = [self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [signInSignal subscribeNext:^(UIButton *sender) {
        NSLog(@"sender = %@",sender.currentTitle);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validAccountSignal, validPasswordSignal]] reduceEach:^id{
        ;
    }];
//    RAC(self.signInButton,enabled) = []
    
    RAC(self.signInButton,enabled) = [RACSignal combineLatest:@[]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)isValidAccountName:(NSString *)account{
    return account.length > 6;
}
- (BOOL)isValidPassword:(NSString *)password{
    return password.length > 6;
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
