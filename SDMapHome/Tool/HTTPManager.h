//
//  HTTPManager.h
//  SDMapHome
//
//  Created by Allen on 16/4/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HTTPManager : NSObject

- (void)sd_requestGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id successObject))success fail:(void(^)(NSError *))fail;

@end
