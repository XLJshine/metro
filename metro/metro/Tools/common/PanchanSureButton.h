//
//  PanchanSureButton.h
//  PanChan_ProjectPods
//
//  Created by Cssweb888888 on 16/6/14.
//  Copyright © 2016年 北京中软万维上海分公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PanchanSureButtonBlock)(NSInteger tag);
@interface PanchanSureButton : UIButton
@property(nonatomic,strong)PanchanSureButtonBlock block;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title completion:(PanchanSureButtonBlock)block;
//统一按钮风格
- (void)consolidateStyle;
@end
