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
    
    
//    RACSignal *signInSignal = [self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside];
//    [signInSignal subscribeNext:^(UIButton *sender) {
//        NSLog(@"sender = %@",sender.currentTitle);
//    }];
    
    //聚合信号combineLatest
    RACSignal *signUpAcitveSignal = [RACSignal combineLatest:@[validAccountSignal,validPasswordSignal] reduce:^id(NSNumber *usernameVaild, NSNumber *passwordVaild){
        return @([usernameVaild boolValue] && [passwordVaild boolValue]);
    }];
    
    [signUpAcitveSignal subscribeNext:^(NSNumber *signUpActice) {
        self.signInButton.enabled = [signUpActice boolValue];
    }];
    
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]
        doNext:^(id x) {
            self.signInButton.enabled = NO;
            
        }]
        flattenMap:^id(id value) {
        return [self signInSignal];
        }] subscribeNext:^(NSNumber *signedIn) {
            self.signInButton.enabled = YES;
            BOOL success = [signedIn boolValue];
            if (success) {
            NSLog(@"Sign in successfully");
            }
//        NSLog(@"rsult = %@",success);
    }];
    
    
}
- (RACSignal *)signInSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self signInWithUsername:self.accountTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)isValidAccountName:(NSString *)account{
    return account.length > 5;
}
- (BOOL)isValidPassword:(NSString *)password{
    return password.length > 5;
}
- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(SDSignInResponse)completeBlock{
    double delayInSeconds = 2.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        BOOL success = [username isEqualToString:@"shendong"] && [password isEqualToString:@"123456"];
        completeBlock(success);
    });
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
