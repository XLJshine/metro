//
//  PanchanRefreshGifHeader.h
//  盘缠
//
//  Created by Cssweb888888 on 16/7/15.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#import "MJRefreshGifHeader.h"
typedef void (^refreshHeadercompletion)(void);
//@interface PanchanRefreshGifHeader : MJRefreshGifHeader
@interface PanchanRefreshGifHeader : MJRefreshStateHeader
@property(nonatomic,strong)refreshHeadercompletion block;
@property(nonatomic,strong) PanchanRefreshGifHeader *header;
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action beginRefresh:(BOOL)refresh;

@end
