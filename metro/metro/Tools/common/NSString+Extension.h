//
//  NSString+Extension.h
//  licai
//
//  Created by cssweb on 14-11-25.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
+(BOOL)isUserName:(NSString*)userName;

+ (BOOL)isMobileNumber:(NSString *)mobileNumber;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL) validateEmail:(NSString *)email;
+(BOOL)checkLoginPassword:(NSString *)_text;
//+(BOOL)checkPayPassword:(NSString *)_text;
+(BOOL)check6PayPassword:(NSString*)_text;
+(BOOL)checkBankCard:(NSString*)_text WithBank:(NSString*)_bank;
-(NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (CGSize)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font;
- (NSString *)trim;
-(BOOL)isPureNum;

@end
