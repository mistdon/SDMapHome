//
//  SDLoginViewModel.h
//  SDMapHome
//
//  Created by shendong on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDLoginViewModel : NSObject


@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;


- (RACSignal *)signInButtonValid;

- (RACSignal *)signInSignal;

@end
