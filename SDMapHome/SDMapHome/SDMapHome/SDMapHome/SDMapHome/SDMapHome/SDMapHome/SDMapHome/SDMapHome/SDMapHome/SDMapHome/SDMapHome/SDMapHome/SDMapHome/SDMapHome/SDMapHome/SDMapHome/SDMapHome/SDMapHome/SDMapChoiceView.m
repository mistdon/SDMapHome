//
//  SDMapChoiceView.m
//  SDMapHome
//
//  Created by shendong on 16/4/6.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDMapChoiceView.h"

static CGFloat const kMargin = 5;


@implementation SDMapChoiceView
{
    void (^handle)(NSInteger num);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
}
- (void)addSubViews:(NSInteger)num handleBlock:(void (^)(NSInteger))handback{
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat sigleHeight = (height - num * 2 * kMargin)/num;
    for (NSInteger index = 0; index < num; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kMargin, (index * 2 + 1) * kMargin +index * sigleHeight, width - 2 * kMargin, sigleHeight);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = index + 10;
        [button setTitle:[NSString stringWithFormat:@"%ld",(long)button.tag] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        handle = handback;
        [self addSubview:button];
    }
}
- (void)buttonClicked:(UIButton *)sender{
    handle(sender.tag - 10);
}


@end
