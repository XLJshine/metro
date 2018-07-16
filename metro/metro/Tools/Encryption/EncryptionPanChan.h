//
//  EncryptionPanChan.h
//  AESEncryption
//
//  Created by changxin on 14-11-27.
//  Copyright (c) 2014年 changxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionPanChan : NSObject

//加密字符串
+ (NSData*) AES128Encrypt:(NSString *)EncryStr key:(NSString *)aKey;
//MD5加密
+ (NSString*) md5ChangedWith:(NSString*)sourceStr;
//根据DATA 转换成 STRING
+ (NSString *)hexStringFromData:(NSData *)myD;
@end

