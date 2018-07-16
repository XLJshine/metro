//
//  ScrollKit.h
//  licai
//
//  Created by hxf on 15/7/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScrollKit : NSObject

@property (nonatomic, assign) BOOL isKeyboardShown;  //键盘是否显示

#pragma mark --处理键盘显示
-(void)keyboardShowWithNotification:(NSNotification *)noti WithScrollView:(UIScrollView *)scrollView;

#pragma mark --处理键盘隐藏
-(void)keyboardHideWithNotification:(NSNotification *)noti WithScrollView:(UIScrollView *)scrollView;

#pragma mark --查找第一响应者
- (UIView *)findFirstResponderBeneathView:(UIView *)view;

#pragma mark --单例
+(ScrollKit *)scroll;


@end
