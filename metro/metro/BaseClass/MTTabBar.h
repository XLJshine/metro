//
//  MTTabBar.h
//  metro
//
//  Created by 熊良军 on 2018/7/16.
//  Copyright © 2018年 cssweb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTTabBar;
//MyTabBar的代理必须实现addButtonClick，以响应中间“+”按钮的点击事件
@protocol MTTabBarDelegate <NSObject>

-(void)addButtonClick:(MTTabBar *)tabBar;

@end

@interface MTTabBar : UITabBar
//指向中间“+”按钮
@property (nonatomic,strong) UIButton *addButton;
//指向“添加”标签
@property (nonatomic,strong) UILabel *addLabel;
//指向MyTabBar的代理
@property (nonatomic,weak) id<MTTabBarDelegate> mtTabBarDelegate;

@end
