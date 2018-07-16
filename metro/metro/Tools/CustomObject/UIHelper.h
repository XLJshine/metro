//
//  UIHelper.h
//  gtja_iphone_yht
//
//  Created by Vincent on 13-7-26.
//  Copyright (c) 2013年 huwp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AlertWithTimer.h"
typedef enum{
    inconnected = 0, //网络断开了
    connected = 1, //网络连接了
}NetConnectType;

@interface UIHelper : NSObject

+ (UIHelper *)shareInstance;
//盘缠加载动画
@property (nonatomic,strong)UIView *animationView;
@property (nonatomic,strong)UIImageView *animationImageview;
@property (nonatomic,assign)double angle;
- (void)showPanchanLoadingInView:(UIView *)view;
- (void)hidePanchanLoading;

+ (void)setWindow:(UIWindow *)window;

+ (void)alert:(NSString *)message completionBlock:(void (^)(void))completion;
+ (void)alertNetConnectType:(NetConnectType)type completionBlock:(void (^)(void))completion;
+ (void)alertWithTitle:(NSString *)title AndMessage:(NSString *)message completionBlock:(void (^)(void))completion;
//// 三秒钟消失，提示窗
//+ (void)alert2:(NSString *)message completionBlock:(void (^)(void))completion;
// 三秒钟消失，提示窗
+ (void)alert3:(NSString *)message inView:(UIView *)view;

+ (void)tip:(NSString *)message;
+ (void)tip:(NSString *)message inView:(UIView *)view;

+ (void)confirmTitle:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL isConfirm))completion;
// 添加 按钮“取消”在左， “确定”在右
+ (void)confirmTitle2:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL isConfirm))completion;
// 添加自定义左、右按钮
+ (void)confirmTitle3:(NSString *)title message:(NSString *)message leftTip:(NSString *)leftTip rightTip:(NSString *)rightTip completion:(void (^)(NSInteger buttonIndex))completion;
// 添加 明日解锁(上)  找回交易密码(中)  拨打客服热线(下)
+ (void)confirmTitle4:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL bFindTradePassword, BOOL bDialServicePhone))completion;

// 拨打客服电话
+ (void)dialServicePhone;

+ (void)showProgress:(BOOL)animated;
+ (void)showProgress:(BOOL)animated inView:(UIView *)view;
+ (void)hideProgress:(BOOL)animated;
+ (void)hideProgress:(BOOL)animated inView:(UIView *)view;
+ (void)setProgressText:(NSString *)text;
+ (void)setProgressText:(NSString *)text inView:(UIView *)view;

+(CGFloat)getVesion;
+(BOOL)isLeftBack:(BOOL)isback;
//友盟统计
//+(void)youMengStarView:(NSString*)controllerName;
//+(void)youmengEndView:(NSString*)controllerName;

+(BOOL)validatePassword:(NSString *)pwd; //判断是否6-16位纯数字

+(NSString*)httpErrorCode:(int)errCode;

+ (void)panchanLoginviewShowWithPre:(UIViewController *)preVc  animated:(BOOL)animated completion:(void(^)(void))completion;

@end
