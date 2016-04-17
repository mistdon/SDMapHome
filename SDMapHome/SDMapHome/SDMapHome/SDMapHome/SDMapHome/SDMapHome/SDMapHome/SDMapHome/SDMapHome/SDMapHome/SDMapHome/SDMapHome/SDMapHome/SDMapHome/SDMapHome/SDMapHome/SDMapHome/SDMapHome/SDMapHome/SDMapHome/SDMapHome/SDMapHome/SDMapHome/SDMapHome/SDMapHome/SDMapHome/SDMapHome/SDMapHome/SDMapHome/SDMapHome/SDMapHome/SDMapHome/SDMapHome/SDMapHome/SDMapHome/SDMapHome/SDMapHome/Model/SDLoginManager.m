//
//  SDLoginManager.m
//  SDMapHome
//
//  Created by Allen on 16/4/14.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDLoginManager.h"

@implementation SDLoginManager

+ (instancetype)shareInstance{
    static SDLoginManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SDLoginManager alloc] init];
    });
    return manager;
}

@end
