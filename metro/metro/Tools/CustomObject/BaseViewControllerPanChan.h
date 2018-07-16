//
//  BaseViewController.h
//  licai
//
//  Created by cssweb on 14-11-19.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustData.h"
#import "Macro.h"
#import "NSString+BeeExtension.h"
#import "UIButton+CountDown.h"

/**
 *  交易密码找回的方式
 */
typedef NS_ENUM(NSInteger, findPattern) {
    /**
     *  通过旧交易密码
     */
    kThroughOldPwd,
    /**
     *  通过密保问题
     */
    kThroughSecurityQuestion,
    /**
     *  通过短信、身份证号和银行卡
     */
    kThroughIdntify
};

@interface BaseViewControllerPanChan : UIViewController
-(void)resign:(UIView *)view;
-(void)leftBarAction;

- (void)cornerButton:(UIButton *)button;
@end
