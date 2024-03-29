//
//  SDFileToolClass.h
//  SDMapHome
//
//  Created by shendong on 16/4/13.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const SDCrashFileDirectory;


@interface SDFileToolClass : NSObject

+ (nullable NSArray<NSDictionary *> *)sd_getRootClasses;

//Crash logs About
+ (BOOL)writeCrashFileOnDocumentsException:(nonnull NSDictionary *)exception;
+ (nullable NSArray *)sd_getCrashLogs;
+ (BOOL)sd_clearCrashLogs;
@end
