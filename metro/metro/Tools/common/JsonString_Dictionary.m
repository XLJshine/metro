//
//  JsonString-Dictionary.m
//  时时投
//
//  Created by 熊良军 on 16/2/26.
//  Copyright © 2016年 yunjie. All rights reserved.
//

#import "JsonString_Dictionary.h"

@implementation JsonString_Dictionary
//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

//字典转json格式字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


//字符串切割工具
+ (NSString *)string:(NSString *)string componentsSeparatedByStartString:(NSString *)separatedStartString  endString:(NSString *)separatedEndString{
    NSArray *array = [string componentsSeparatedByString:separatedStartString]; //从字符separatedStartString中分隔成2个元素的数组
    //NSLog(@"array:%@",array); //结果是A和B
    NSString *returnString = [array objectAtIndex:1];
    
    NSRange range;
    if (separatedEndString != nil&&separatedEndString.length != 0) {
         range = [returnString rangeOfString:separatedEndString];//匹配得到的下标
    }
   
    //NSLog(@"rang:%@",NSStringFromRange(range));
    NSString *lastChar;
    NSString *lastChar1;
    if (range.length > 0&&separatedEndString != nil&&separatedEndString.length != 0) {
        returnString = [returnString substringToIndex:range.location];//截取范围类的字符串
    }
    NSRange range1;
    range1.length = 1;
    range1.location = returnString.length - 1;
    lastChar = [returnString substringWithRange:range1];
    
    NSRange range2;
    range2.length = 1;
    range2.location = returnString.length - 2;
    lastChar1 = [returnString substringWithRange:range2];
    //NSLog(@"lastChar = %@",lastChar);
    if ([lastChar isEqualToString:@"}"]) {
        returnString = [returnString substringToIndex:range1.location];
    }
    if ([lastChar1 isEqualToString:@"}"]||[lastChar1 isEqualToString:@" "]) {
        returnString = [returnString substringToIndex:range2.location];
    }
    NSLog(@"截取的值为：%@",returnString);
    return returnString;
}


@end
