//
//  UITableView+MJRefresh.h
//  SDMapHome
//
//  Created by Allen on 16/4/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh/MJRefresh.h"

@interface UITableView (MJRefresh)


- (void)headerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block ;

- (void)headerBeginRefresh;

- (void)headerEndRefresh;

- (void)footerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block;

- (void)footerBeginfresh;

- (void)footerEndFresh;

- (void)footerEndRefreshNoMoreData;

- (void)footerResetNoMoreData;
@end
