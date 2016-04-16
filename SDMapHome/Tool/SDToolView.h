//
//  SDToolView.h
//  SDMapHome
//
//  Created by shendong on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SDProgressViewType) {
    SDProgressViewTypeNone,
    SDProgressViewTypeSuccess,
    SDProgressViewTypeFail,
    SDProgressViewTypeInfo,
    SDProgressViewTypeError
};

@interface SDToolView : NSObject

@end
