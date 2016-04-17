//
//  SDLoginViewModel.m
//  SDMapHome
//
//  Created by shendong on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDLoginViewModel.h"

@implementation SDLoginViewModel{
    RACSignal *accountValid;
    RACSignal *passwordValid;
}
- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}
- (void)initialize{
    accountValid = RACObserve(self, account);
    passwordValid =RACObserve(self, password);
}
- (RACSignal *)signInButtonValid{
    RACSignal *buttonValid = [RACSignal combineLatest:@[accountValid, passwordValid] reduce:^id(NSString *account, NSString *password){
        return @(account.length >5 && password.length >5);
    }];
    return buttonValid;
}
- (RACSignal *)signInSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self signIn:self.account password:self.password complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (void)signIn:(NSString *)account password:(NSString *)password complete:(void(^)(BOOL success))completeHander{
    double delayInSeconds = 2.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        BOOL success = [account isEqualToString:@"shendong"] && [password isEqualToString:@"123456"];
        completeHander(success);
    });
}
@end
