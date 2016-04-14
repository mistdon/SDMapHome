//
//  SDFileToolClass.m
//  SDMapHome
//
//  Created by shendong on 16/4/13.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDFileToolClass.h"

NSString * const SDCrashFileDirectory = @"SDMapHomeCrashFileDirectory";
@interface SDFileToolClass ()
@end
@implementation SDFileToolClass

+ (void)initialize{
    if (self == [SDFileToolClass class] ) {
        
    }
}
+ (nullable NSArray<NSDictionary *> *)sd_getRootClasses{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDRootClass" ofType:@"plist"];
    NSDictionary *array = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *result = [array objectForKey:@"SDMapHomeRootClass"];
    return result;
}
+ (NSString *)sd_getDocumentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
+ (NSString *)sd_getCachesPath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
+ (BOOL)writeFileToDocument:(NSString *)filePath withData:(NSDictionary *)data{
    return  [data writeToFile: filePath atomically:YES];
}
+ (BOOL)writeCrashFileOnDocumentsException:(NSDictionary *)exception{
    NSString *time = [[NSDate date] formattedDateWithFormat:@"yyyyMMddHHmmss" locale:[NSLocale currentLocale]];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *crashname = [NSString stringWithFormat:@"%@_%@Crashlog.plist",time,infoDictionary[@"CFBundleName"]];
    NSString *crashPath = [[self sd_getCachesPath] stringByAppendingPathComponent:SDCrashFileDirectory];
    NSFileManager *manager = [NSFileManager defaultManager];
    //设备信息
    NSMutableDictionary *deviceInfos = [NSMutableDictionary dictionary];
    [deviceInfos setObject:[infoDictionary objectForKey:@"DTPlatformVersion"] forKey:@"DTPlatformVersion"];
    [deviceInfos setObject:[infoDictionary objectForKey:@"CFBundleShortVersionString"] forKey:@"CFBundleShortVersionString"];
    [deviceInfos setObject:[infoDictionary objectForKey:@"UIRequiredDeviceCapabilities"] forKey:@"UIRequiredDeviceCapabilities"];
    
    BOOL isSuccess = [manager createDirectoryAtPath:crashPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuccess) {
        NSLog(@"文件夹创建成功");
        NSString *filepath = [crashPath stringByAppendingPathComponent:crashname];
        NSMutableDictionary *logs = [NSMutableDictionary dictionaryWithContentsOfFile:filepath];
        if (!logs) {
            logs = [[NSMutableDictionary alloc] init];
        }
        //日志信息
        NSDictionary *infos = @{@"Exception":exception,@"DeviceInfo":deviceInfos};
        [logs setObject:infos forKey:[NSString stringWithFormat:@"%@_crashLogs",infoDictionary[@"CFBundleName"]]];
        BOOL writeOK = [logs writeToFile:filepath atomically:YES];
        NSLog(@"write result = %d,filePath = %@",writeOK,filepath);
        return writeOK;
    }else{
        return NO;
    }
}
+ (nullable NSArray *)sd_getCrashLogs{
     NSString *crashPath = [[self sd_getCachesPath] stringByAppendingPathComponent:SDCrashFileDirectory];
     NSFileManager *manager = [NSFileManager defaultManager];
     NSArray *array = [manager contentsOfDirectoryAtPath:crashPath error:nil];
     NSMutableArray *result = [NSMutableArray array];
    if (array.count == 0) return nil;
    for (NSString *name in array) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[crashPath stringByAppendingPathComponent:name]];
        [result addObject:dict];
    }
    return result;
}
+ (void)sd_clearCrashLogs{
     NSString *crashPath = [[self sd_getCachesPath] stringByAppendingPathComponent:SDCrashFileDirectory];
    BOOL bRet = [[NSFileManager defaultManager] fileExistsAtPath:crashPath];
    
    if (bRet) {
//        return [[[NSFileManager defaultManager] removeItemAtPath:crashPath error:nil] ];
        return[[NSFileManager defaultManager] removeItemAtPath:crashPath error:nil];
    }
}
@end
