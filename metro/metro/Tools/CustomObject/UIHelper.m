//
//  UIHelper.m
//  gtja_iphone_yht
//
//  Created by Vincent on 13-7-26.
//  Copyright (c) 2013年 huwp. All rights reserved.
//

#import "UIHelper.h"
#import "MBProgressHUD.h"
#import "UIAlertView+Blocks.h"
#import "ACache.h"
#import "SGInfoAlert.h"
@implementation UIHelper{
    
}

static UIWindow *_window;
+ (UIHelper *)shareInstance{
    static UIHelper *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UIHelper alloc] init];
       
    });
    return _sharedClient;
}



- (void)showPanchanLoadingInView:(UIView *)view{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat pro = screenW/320.0;
    
    [self hidePanchanLoading];
    self.animationView = [[UIView alloc]init];
    self.animationImageview = [[UIImageView alloc]init];
    self.angle = 10.0;
    self.animationView.frame = CGRectMake((screenW - 60*pro)* 0.5, (screenH - 60*pro)* 0.5, 60*pro, 60*pro);
     [view addSubview:self.animationView];
     self.animationImageview.frame = CGRectMake(0.0, 0.0, 60*pro, 60*pro);
    self.animationImageview.image = [UIImage imageNamed:@"loding"];
    [self.animationView addSubview:self.animationImageview];
    
    //[self.animationImageview stopAnimating];
    //[self startAnimation];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10000;
    [self.animationImageview.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
}
-(void) startAnimation
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.animationImageview.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    self.angle += 10;
    [self startAnimation];
}
- (void)hidePanchanLoading{
    [self.animationImageview removeFromSuperview];
    [self.animationView removeFromSuperview];
    self.animationView = nil;
    self.animationImageview = nil;
}

+ (void)setWindow:(UIWindow *)window;
{
    _window = window;
}

+ (id)getTabBarStoryBoard:(NSString *)name;
{
    UIStoryboard * getBoard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    UIViewController *controller = [getBoard instantiateInitialViewController];
    return controller;
}

+ (void)alert:(NSString *)message completionBlock:(void (^)(void))completion
{
    [UIAlertView showWithTitle:@"" message:message handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (completion) {
            completion();
        }
    }];
}

+ (void)alertNetConnectType:(NetConnectType)type completionBlock:(void (^)(void))completion
{
    if (type == inconnected) {
        [UIAlertView showWithTitle:@"" message:@"网络异常,无法请求到相关数据！" handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (completion) {
                completion();
            }
        }];
    }else if(type == connected){
        [UIAlertView showWithTitle:@"" message:@"网络已连接！" handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (completion) {
                completion();
            }
        }];
    
    }
    
}

+ (void)alertWithTitle:(NSString *)title AndMessage:(NSString *)message completionBlock:(void (^)(void))completion{
    [UIAlertView showWithTitle:title message:message handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (completion) {
            completion();
        }
     }];
}

+ (void)alert3:(NSString *)message inView:(UIView *)view{
    [[SGInfoAlert alert] showInfo:message
                          bgColor:[[UIColor blackColor] CGColor]
                           inView:view
                         vertical:0.8f showTime:2.0f
                         showType:charactersInRectangle
     fontSize:14.0f];
}

+ (void)tip:(NSString *)message
{
    [UIHelper hideProgress:YES];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:_window];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.labelFont = [UIFont boldSystemFontOfSize:14];
    HUD.margin = 10;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.yOffset = 180;
    [_window addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
}

+ (void)tip:(NSString *)message inView:(UIView *)view
{
    [UIHelper hideProgress:YES inView:view];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.labelFont = [UIFont boldSystemFontOfSize:14];
    HUD.margin = 10;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.yOffset = 180;
    [view addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}

+ (void)confirmTitle:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL isConfirm))completion
{
    [UIAlertView showConfirmationDialogWithTitle:title message:message handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(completion){
            completion(buttonIndex == alertView.cancelButtonIndex);
        }
    }];
}

// 添加 按钮“取消”在左， “确定”在右
+ (void)confirmTitle2:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL isConfirm))completion
{
    [UIAlertView showConfirmationDialogWithTitle2:title message:message handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(completion){
            completion(buttonIndex == alertView.cancelButtonIndex);
        }
    }];
}

// 添加自定义左、右按钮
+ (void)confirmTitle3:(NSString *)title message:(NSString *)message leftTip:(NSString *)leftTip rightTip:(NSString *)rightTip completion:(void (^)(NSInteger buttonIndex))completion
{
    [UIAlertView showConfirmationDialogWithTitle3:title message:message leftTip:leftTip rightTip:rightTip handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (completion) {
            completion(buttonIndex);
        }
    }];

}


// 添加 明日解锁(上)  找回交易密码(中)  拨打客服热线(下)
+ (void)confirmTitle4:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL bFindTradePassword, BOOL bDialServicePhone))completion{
    [UIAlertView showConfirmationDialogWithTitle4:title message:message handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        BOOL bFind = FALSE, bDial = FALSE;
        if (buttonIndex == 1) {
            bFind = TRUE;
        }else if (buttonIndex == 2){
            bDial = TRUE;
        }
        if (completion) {
            completion(bFind, bDial);
        }
    }];
}

//拨打客服电话
+ (void)dialServicePhone{
    [UIHelper confirmTitle3:@"" message:@"尊敬的用户，正在为您接通盘缠客服热线400-640-8811，是否继续？" leftTip:@"取消" rightTip:@"确认"  completion:^(NSInteger buttonIndex){
        if (buttonIndex == 1) {
            [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:@"tel://4006408811"]];
        }
    }];
}

+ (UIView*)testANIView:(UIView*)tempView{
    UIView * view =  [[UIView alloc]initWithFrame:[ [UIScreen mainScreen]bounds]];
//    UIView * view =  [[UIView alloc]initWithFrame:CGRectMake(tempView.frame.origin.x - 50, tempView.frame.origin.y, tempView.frame.size.width + 100, tempView.frame.size.height)];

    view.center = tempView.center;
    UIImageView* mainImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 152)];
    mainImageView.center = view.center;
    mainImageView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"Ani1"],
                                     [UIImage imageNamed:@"Ani2"],
                                     [UIImage imageNamed:@"Ani3"],
                                     [UIImage imageNamed:@"Ani4"],nil];
    [mainImageView setAnimationDuration:0.5f];
    [mainImageView setAnimationRepeatCount:0];
    
    [mainImageView startAnimating];
    
    [view addSubview:mainImageView];
    return view;
}


+ (void)showProgress:(BOOL)animated inView:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD show:animated];
}

/*
+ (void)showProgress:(BOOL)animated inView:(UIView *)view{
 
    UIView * custView = [UIHelper testANIView:view];
    //UIView * viewOne = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
//    [HUD setFrame:CGRectMake(viewOne.frame.origin.x - 50, viewOne.frame.origin.y, viewOne.frame.size.width + 100, viewOne.frame.size.height)];
//    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = custView;
    HUD.alpha = 0.8;
    
//    HUD.xOffset = -20;
//    NSLog(@"pppppppppp: %f ",HUD.xOffset);
    NSLog(@"gggggggggg: %@", HUD);

    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD show:animated];
}
*/
+ (void)showProgress:(BOOL)animated
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:_window];
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.removeFromSuperViewOnHide = YES;
    [_window addSubview:HUD];
    [HUD show:animated];
}

+ (void)hideProgress:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:_window animated:animated];
}

+ (void)hideProgress:(BOOL)animated inView:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}

+ (void)setProgressText:(NSString *)text
{
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:_window];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithWindow:_window];
        HUD.animationType = MBProgressHUDAnimationZoom;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.removeFromSuperViewOnHide = YES;
        [_window addSubview:HUD];
        [HUD show:YES];
    }
    HUD.labelFont = [UIFont boldSystemFontOfSize:14];
    HUD.labelText = text;
}

+ (void)setProgressText:(NSString *)text inView:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:view];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
        HUD.animationType = MBProgressHUDAnimationZoom;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.removeFromSuperViewOnHide = YES;
        [view addSubview:HUD];
        [HUD show:YES];
    }
    HUD.labelFont = [UIFont boldSystemFontOfSize:14];
    HUD.labelText = text;
}



+(CGFloat)getVesion{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    
    return (CGFloat)version;
}
+(BOOL)isLeftBack:(BOOL)isback{
    
    return isback;
}

+(BOOL)validatePassword:(NSString *)pwd{
    NSString *regex = @"^[0-9]{6,16}$";
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [regexTest evaluateWithObject:pwd];
}

+(NSString*)httpErrorCode:(int)errCode{
    
    NSString * errorResult = @"";
    switch (errCode) {
        case -1:
        {
            errorResult = @"失败";
        }
            break;
        case 100001:{
            errorResult = @"数据库异常";
        }
            break;
        case 100002:{
            errorResult = @"系统异常";
        }
            break;
        case 100003:{
            errorResult = @"第三方系统异常";
        }
            break;
        case 100004:{
            errorResult = @"请求校验失败";
        }
            break;
        case 100005:{
            errorResult = @"session 失效";
        }
            break;
        case 200001:{
            errorResult = @"入参为空值";
        }
            break;
        case 200002:{
            errorResult = @"输入参数不符合规范";
        }
            break;
        case 200003:{
            errorResult = @"用户名已经被注册";
        }
            break;
        case 200004:{
            errorResult = @"用户不存在";
        }
            break;
        case 200005:{
            errorResult = @"黑名单";
        }
            break;
        case 200006:{
            errorResult = @"登录密码错误上限";
        }
            break;
        case 200007:{
            errorResult = @"登录密码不符合规则";
        }
            break;
        case 200008:{
            errorResult = @"密码锁定";
        }
            break;
        case 200009:{
            errorResult = @"用户名密码不匹配";
        }
            break;
        case 200010:{
            errorResult = @"密保问题错误次数上限";
        }
            break;
        case 200011:{
            errorResult = @"密保问题回答错误";
        }
            break;
        case 200012:{
            errorResult = @"密保找回功能已关闭";
        }
            break;
        case 200013:{
            errorResult = @"手机发送短信次数上限";
        }
            break;
        case 200014:{
            errorResult = @"设备发送短信次数上限";
        }
            break;
        case 200015:{
            errorResult = @"交易密码未设置";
        }
            break;
        case 200016: {
            errorResult = @"逻辑卡号未绑定";
        }
            break;
        case 200017:{
            errorResult = @"交易密码错误上限";
        }
            break;
        case 200018:{
            errorResult = @"短信验证码错误";
        }
            break;
        default:
            break;
    }
    
    return errorResult;

}



@end
