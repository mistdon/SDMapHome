//
//  SDLoginManager.h
//  SDMapHome
//
//  Created by Allen on 16/4/14.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDLoginManager : NSObject

@property (nonatomic, copy) NSString *logIn;

+ (instancetype)shareInstance;

@end
