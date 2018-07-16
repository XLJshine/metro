//
//  KeyboardActionMethod.h
//  SchoolCard_Students
//
//  Created by cssweb on 15/11/25.
//  Copyright (c) 2015年 北京中软万维上海分公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeyboardActionMethod : NSObject

//UIView页面上的 键盘弹起 收回方法
//viewUnderY的值为 目标输入框下边缘的Y值，用以和键盘弹出时的Y值相比较大小
+(void)keyboardShowActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndKeyboardNotification:(NSNotification *)noti;

+(void)keyboardHiddenActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndKeyboardNotification:(NSNotification *)noti;


//UIScrollView页面上的 键盘弹起 收回方法
//viewUnderY的值为 目标输入框下边缘的Y值，用以和键盘弹出时的Y值相比较大小
//contentSizeHeight 值为原先scrollView的 contentSize的高
+(void)keyboardShowActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndSuperScrollView:(UIScrollView*)scrollView AndKeyboardNotification:(NSNotification *)noti;

+(void)keyboardHiddenActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndSuperScrollView:(UIScrollView*)scrollView AndScrollViewContentSizeHeight:(float)contentSizeHeight AndKeyboardNotification:(NSNotification *)noti;
@end
