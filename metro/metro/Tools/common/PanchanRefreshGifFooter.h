//
//  PanchanRefreshGifFooter.h
//  盘缠
//
//  Created by Cssweb888888 on 16/7/15.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#import "MJRefreshAutoGifFooter.h"
typedef void (^refreshFootercompletion)(void);
//@interface PanchanRefreshGifFooter : MJRefreshAutoGifFooter
@interface PanchanRefreshGifFooter : MJRefreshAutoStateFooter
@property(nonatomic,strong)refreshFootercompletion block;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
