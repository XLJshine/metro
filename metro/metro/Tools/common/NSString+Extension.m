//
//  NSString+Extension.m
//  licai
//
//  Created by cssweb on 14-11-25.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import "NSString+Extension.h"
//#import <UIKit/UIKit.h>

@implementation NSString (Extension)

+ (BOOL)isMobileNumber:(NSString *)mobileNumber{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
//        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
//        || ([regextestct evaluateWithObject:mobileNumber] == YES)
//        || ([regextestcu evaluateWithObject:mobileNumber] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    NSString * firstNum = [mobileNumber substringToIndex:1];
    if([firstNum isEqualToString:@"1"] && mobileNumber.length == 11){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    NSUInteger location = 0;
    
    for ( ; location < length; location++)
    {
        if (![characterSet characterIsMember:charBuffer[location]])
        {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length-location)];
}

- (NSString *)trim;
{
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return result;
}

//// 支付密码 为6-16位数字、字母的组合
//
//+ (BOOL)checkPayPassword:(NSString *)_text{
//    NSString *regex = @"^[A-Za-z0-9]{6,16}$";
//    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [test evaluateWithObject:_text];
//}
//支付密码6位纯数字
+(BOOL)check6PayPassword:(NSString*)_text{
    NSString *regex = @"^[0-9]{6}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:_text];
}

+(BOOL)isUserName:(NSString*)userName
{
    
//    NSString *   regex = @"(^[u4e00-u9fa5],{0,20}$)";//只验证汉字
    NSString *   regex = @"^[\u4E00-\u9FA5]*$";//只验证汉字

//    NSString *   regex = @"(/^\s*[\u4e00-\u9fa5]{1,}[\u4e00-\u9fa5.·]{0,15}[\u4e00-\u9fa5]{1,}\s*$/)";

    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:userName];
}

+(BOOL)checkLoginPassword:(NSString *)_text
{
//    NSString *Regex = @"//w{6,16}";
//    NSString *Regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
//    NSString *Regex = @"(?![a-z]+$|[0-9]+$)^[a-zA-Z0-9]{6,16}$";
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)^.{6,16}";

    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:_text];
    
}
+(BOOL)checkBankCard:(NSString*)_text WithBank:(NSString*)_bank{
    BOOL result = NO;
    NSArray * zhaoshangBIN = [NSArray arrayWithObjects:
                              @"356885",@"356886",@"356887",@"356888",
                              @"356889",@"356890",
                              @"402658",@"439188",@"439225",
                              @"439227",@"479228",@"479229",
                              @"518710",@"518718",@"524011",
                              @"545619",@"545623",@"545947",
                              @"622575",@"622576",@"622577",@"622578",
                              @"622579",@"622580",@"622581",@"622582",
                              @"622588",@"622598",@"690755",nil];
    NSArray * zhongguoBIN = [NSArray arrayWithObjects:
                             @"356833",@"356835",
                             @"400941",@"400942",
                             @"409665",@"409666",@"409667",@"409668",
                             @"409669",@"409670",@"409671",@"409672",
                             @"424106",@"424107",@"424108",@"424109",
                             @"424110",@"424111",@"424902",
                             @"438088",@"451291",@"456351",@"493878",
                             @"518378",@"518379",@"518474",@"518475",
                             @"518476",
                             @"522153",@"524864",@"524865",@"525745",
                             @"525746",
                             @"540297",@"540838",@"541068",@"547628",
                             @"547648",@"547766",@"552742",@"553131",
                             @"558808",@"558809",@"558868",@"601382",
                             @"622346",@"622347",@"622348",
                             @"622750",@"622751",@"622752",@"622753",
                             @"622754",@"622755",@"622756",@"622757",
                             @"622758",@"622759",@"622760",@"622761",
                             @"622762",@"622763",@"622770",nil];
    NSArray * zhongxinBIN = [NSArray arrayWithObjects:@"622696",@"622698", nil];
    NSString * sub6_text = [_text substringToIndex:6];
    NSArray * tempArray;
    if([_bank isEqualToString:@"zhaoshang"]){
        tempArray = zhaoshangBIN;
    }else if ([_bank isEqualToString:@"zhongguo"]){
        tempArray = zhongguoBIN;
    }else if ([_bank isEqualToString:@"zhongxin"]){
        tempArray = zhongxinBIN;
    }
    for(NSString * code in tempArray){
        if([sub6_text isEqualToString:code]){
            result = YES;
            break;
        }
    }
    return result;
}



//得到字符串的高度和宽度
- (CGSize)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

//是否是纯数字
-(BOOL)isPureNum{
    NSString * regex = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
@end
