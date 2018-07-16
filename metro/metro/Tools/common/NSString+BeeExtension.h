//
//  NSString+BeeExtension.h
//  Panchan
//
//  Created by cssweb on 16/6/23.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BeeExtension)
/**
 *  判断输入是否为空
 *
 *  @return 空返回yes，反之返回no
 */
- (BOOL)empty;
/**
 *  判断是否为合法的手机号码
 *
 *  @return 合法返回yes, 不合法返回no
 */
- (BOOL)validateTel;
/**
 *  判断是否为合法的身份证号码
 *
 *  @return 合法的返回yes, 不合法返回no
 */
- (BOOL)validateID;
/**
 *  判断是否为合法的银行卡号
 *
 *  @return 合法的返回yes, 不合法的返回no
 */
- (BOOL)validateBankNo;
/**
 *  银行卡号转换成四位一组
 *
 *  @return 四位一组的银行卡号
 */
-(NSString *)normalNumToBankNum;
/**
 *  四位一组的银行卡号转为不带空格
 *
 *  @return 不加空格的银行卡号
 */
-(NSString *)bankNumToNormalNum;
@end
