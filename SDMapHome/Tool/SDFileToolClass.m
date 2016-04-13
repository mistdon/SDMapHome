//
//  SDFileToolClass.m
//  SDMapHome
//
//  Created by shendong on 16/4/13.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDFileToolClass.h"

@implementation SDFileToolClass

+ (nullable NSArray<NSDictionary *> *)sd_getRootClasses{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDRootClass" ofType:@"plist"];
    NSDictionary *array = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *result = [array objectForKey:@"SDMapHomeRootClass"];
    return result;
}

@end
