//
//  SDMapChoiceView.h
//  SDMapHome
//
//  Created by shendong on 16/4/6.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDMapChoiceView : UIView

/**
 *  为保证每一个button为正方形,长度应为宽度的num倍(其中num为子视图的个数)
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame;

- (void)addSubViews:(NSInteger)num handleBlock:(void(^)(NSInteger tag))handback;

@end
