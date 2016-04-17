//
//  HTTPManager.m
//  SDMapHome
//
//  Created by Allen on 16/4/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "HTTPManager.h"
#import "AFNetworking.h"

static NSString *const KBaseURL = @"https://api.douban.com/v2/book";

@implementation HTTPManager

- (void)sd_requestGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"applicaiton/json",@"image/png",nil];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

@end
