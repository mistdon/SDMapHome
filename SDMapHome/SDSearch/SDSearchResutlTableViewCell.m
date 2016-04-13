//
//  SDSearchResutlTableViewCell.m
//  SDMapHome
//
//  Created by shendong on 16/4/7.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "SDSearchResutlTableViewCell.h"

@implementation SDSearchResutlTableViewCell{
    UIImageView *leftImageView;
    UILabel *titleLable;
    UILabel *detailLable;
    UIView  *starView;
    UILabel *commentLable;
    UIButton *indicatorButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self configureSubViews];
    }
    return self;
}
- (void)configureSubViews{
    //1.
    leftImageView   = [[UIImageView alloc] init];
    titleLable      = [[UILabel alloc] init];
    detailLable     = [[UILabel alloc] init];
    starView        = [[UIView alloc] init];
    commentLable    = [[UILabel alloc] init];
    indicatorButton = [[UIButton alloc] init];
    
    [self.contentView addSubview:leftImageView];
    [self.contentView addSubview:titleLable];
    [self.contentView addSubview:detailLable];
    [self.contentView addSubview:starView];
    [self.contentView addSubview:commentLable];
    [self.contentView addSubview:indicatorButton];
    
    
    //test
    titleLable.text = @"title";
    detailLable.text=  @"detail";
    
    [self setNeedsUpdateConstraints];
}
+ (BOOL)requiresConstraintBasedLayout{
    return YES;
}
- (void)updateConstraints{
    WS(ws);
    leftImageView.backgroundColor = [UIColor redColor];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).with.offset(5);
        make.left.equalTo(ws.contentView.mas_left).with.offset(5);
        make.bottom.equalTo(ws.contentView.mas_bottom).with.offset(-5);
        make.width.equalTo(leftImageView.mas_height).multipliedBy(1.0); //等宽高
    }];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageView.mas_right).offset(20);
        make.top.equalTo(ws.contentView.mas_top).offset(5);
        make.right.equalTo(ws.contentView.mas_right).offset(10);
        make.height.mas_equalTo(@20);
    }];
    [detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageView.mas_right).offset(20);
        make.top.equalTo(titleLable.mas_bottom).offset(10);
        make.height.equalTo(titleLable.mas_height).offset(0);
        make.right.equalTo(ws.contentView.mas_right).offset(0);
    }];
    [super updateConstraints];
}
- (void)setcontent{
    [self setNeedsUpdateConstraints];
}
@end
