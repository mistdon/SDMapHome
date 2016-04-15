//
//  SDLoginViewController.h
//  SDMapHome
//
//  Created by shendong on 16/4/14.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SDSignInResponse)(BOOL);

@interface SDLoginViewController : UIViewController

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(SDSignInResponse)completeBlock;

@end
