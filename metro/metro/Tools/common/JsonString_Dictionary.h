//
//  JsonString-Dictionary.h
//  时时投
//
//  Created by 熊良军 on 16/2/26.
//  Copyright © 2016年 yunjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonString_Dictionary : NSObject
//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
//字符串切割工具
+ (NSString *)string:(NSString *)string componentsSeparatedByStartString:(NSString *)separatedStartString  endString:(NSString *)separatedEndString;
@end
