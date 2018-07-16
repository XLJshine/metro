//
//  BlocksOfUIAlertView.m
//  PanChan_ProjectPods
//
//  Created by cssweb on 15/9/14.
//  Copyright (c) 2015年 北京中软万维上海分公司. All rights reserved.
//

#import "BlocksOfUIAlertView.h"
#import <objc/runtime.h>

static NSString *kHandlerAssociatedKey = @"kHandlerAssociatedKey";
@implementation BlocksOfUIAlertView

+ (void)showWithHandler:(UIAlertViewHandler)handler WithAlertView:(UIAlertView*)alertView{
    
    objc_setAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [alertView setDelegate:self];
    [alertView show];
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              handler:(UIAlertViewHandler)handler {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    
    [self showWithHandler:handler WithAlertView:alert];
}

+ (void)showConfirmationDialogWithTitle:(NSString *)title
                                message:(NSString *)message
                                handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:@"取消", nil];
    
    [self showWithHandler:handler WithAlertView:alert];
}

// 添加 按钮“取消”在左， “确定”在右
+ (void)showConfirmationDialogWithTitle2:(NSString *)title
                                 message:(NSString *)message
                                 handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确认", nil];
    
    [self showWithHandler:handler WithAlertView:alert];
}

// 添加 自定义左、右按钮
+ (void)showConfirmationDialogWithTitle3:(NSString *)title
                                 message:(NSString *)message
                                 leftTip:(NSString *)leftTip
                                rightTip:(NSString *)rightTip
                                 handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:leftTip
                                          otherButtonTitles:rightTip, nil];
    
    [self showWithHandler:handler WithAlertView:alert];
}

// 添加 明日解锁(上)  找回交易密码(中)  拨打客服热线(下)
+ (void)showConfirmationDialogWithTitle4:(NSString *)title
                                 message:(NSString *)message
                                 handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"明日解锁", @"找回交易密码", @"拨打客服热线", nil];
    
    [self showWithHandler:handler WithAlertView:alert];
}

@end
