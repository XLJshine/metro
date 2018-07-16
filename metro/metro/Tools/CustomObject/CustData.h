//
//  CustData.h
//  licai
//
//  Created by cssweb on 14-11-25.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIHelper.h"
#import "PayKit.h"
#import "ACache.h"
#import "CommonCrypto/CommonDigest.h"
#import "KeyboardActionMethod.h"

//#import "GYBankCardFormatTextField.h"

// 由于后台返回的数据类型不同，统一用NSSTRING强行包装
#define FMSTRING(SOURCE) [NSString stringWithFormat:@"%@",SOURCE]

#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define isCheckNum @"0123456789"

#define Encry_Key 	@"finace-portal&test%^&" //密码加密解密用的Key

#define NOTI_TO_SY @"noti_to_sy" 

@interface CustData : NSObject

@property (strong,nonatomic) NSMutableDictionary * accountInfo;
@property (strong,nonatomic) NSString * token;   //token
@property (strong,nonatomic) NSString * accountName; //用户名,登录手机号

@property (strong,nonatomic)NSString *deviceToken;// 设备token
+ (CustData *)sharedInstance;
//获取token
+(void)getTokenData;


+ (NSDictionary*)getAccountInfo;

+ (BOOL)isLogined;

+ (void)clearDataWithDismissView;

+ (NSString*)getInputTimesTamp; //根据缓存的时间差值得出入参的timestamp值

+ (NSString*)getTokenByChecked; //获取缓存中的token

+ (NSString*)phoneNumHidePart:(NSString*)phoneNum; //手机号码中间四位隐藏显示“*”

+ (NSString*)IDNumHidePart:(NSString*)IDStr; //身份证号中间隐藏显示“*”

+ (NSString*)formatBankCardLast4Num:(NSString*)sourceString; //银行卡号取后四位

+ (NSString*) md5ChangedWith:(NSString*)sourceStr; //md5加密

+ (BOOL)isUserName:(NSString*)userName;

+ (NSString *)trimByString:(NSString*)tempString;

+ (BOOL)isMobileNumber:(NSString *)mobileNumber;

+ (int)getRandomNumber:(int)from to:(int)to;  // 获取指定范围内的随机数

+ (BOOL) validateIdentityCard: (NSString *)identityCard;

+ (BOOL)checkBankCardNo:(NSString*)cardNo; //验证银行卡号的有效性


+ (NSString*) modifyIdCardxToX:(NSString*)idCard; //把身份证最后一位x转X

+ (CGSize)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font byString:(NSString*)sourceString;

+ (void) setImageFromUrl:(NSString*)urlString sourceImageView:(UIImageView*)imageView placeholderImage:(UIImage *)placeholderImage;

//过滤键盘上除了数字键外的其它键，且限制输入长度
+ (BOOL)onlyContainNumWithUItextField:(UITextField *)txtField InRange:(NSRange)range replacementString:(NSString *)string limitLength:(NSUInteger)length;
+ (NSString *)getAPP_UDID;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


//获取当前__年月日
+ (NSString *)timeGet;
//筛选出字符串中的数字
+ (NSString *)scannerNumberWithString:(NSString *)urlString;

/*******
  盘缠2.0新增
 */
//盘缠2.0登录密码规则
+ (BOOL)loginPasswordRule:(NSString *)password;



@property (strong,nonatomic) NSString * weixinTradeId; //微信订单号

@property (strong,nonatomic) NSString * bankCardInfoKey; //银行卡信息主键

@property (nonatomic, strong) NSString * yiPayInputResult;  //翼支付入参字符串
@property (nonatomic, strong) UIViewController * yiPayPreViewController;    //翼支付插件前的页面
@property (nonatomic, strong) NSString * yiPayTradeId;  //翼支付订单号

+ (NSString *)  removeNonDigits             :(NSString *)string
                andPreserveCursorPosition   :(NSUInteger *)cursorPosition;
+ (NSString *)  insertSpacesEveryFourDigitsIntoString   :(NSString *)string
                andPreserveCursorPosition               :(NSUInteger *)cursorPosition;

+ (BOOL)theDeviceCanUseApplePay;
@property (nonatomic ,strong) NSString * applePayTradeId; //苹果支付我们的订单号
@property (nonatomic ,strong) NSString * applePayServerBackStr; //苹果支付后调用后台拼接结果的返回结果
@property (nonatomic, strong) NSString * SKF_Money; //闪客蜂传入的支付金额

+ (void)authenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;

@end
