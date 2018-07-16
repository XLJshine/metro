//
//  BlocksOfUIAlertView.h
//  PanChan_ProjectPods
//
//  Created by cssweb on 15/9/14.
//  Copyright (c) 2015年 北京中软万维上海分公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^UIAlertViewHandler)(UIAlertView *alertView, NSInteger buttonIndex);

@interface BlocksOfUIAlertView : NSObject

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              handler:(UIAlertViewHandler)handler;

+ (void)showConfirmationDialogWithTitle:(NSString *)title
                                message:(NSString *)message
                                handler:(UIAlertViewHandler)handler;

// 添加 按钮“取消”在左， “确定”在右
+ (void)showConfirmationDialogWithTitle2:(NSString *)title
                                 message:(NSString *)message
                                 handler:(UIAlertViewHandler)handler;

// 添加 自定义左、右按钮
+ (void)showConfirmationDialogWithTitle3:(NSString *)title
                                 message:(NSString *)message
                                 leftTip:(NSString *)leftTip
                                rightTip:(NSString *)rightTip
                                 handler:(UIAlertViewHandler)handler;

// 添加 明日解锁(上)  找回交易密码(中)  拨打客服热线(下)
+ (void)showConfirmationDialogWithTitle4:(NSString *)title
                                 message:(NSString *)message
                                 handler:(UIAlertViewHandler)handler;
@end
