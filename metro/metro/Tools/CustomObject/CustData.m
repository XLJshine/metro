//
//  CustData.m
//  licai
//
//  Created by cssweb on 14-11-25.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import "CustData.h"
#import "MemCache.h"
#import "OpenUDIDPanChan.h"
#import <PassKit/PassKit.h>
#import "TimeXLJ.h"
@implementation CustData

+ (CustData *)sharedInstance
{
    static dispatch_once_t once;
    static CustData *instance = nil;
    dispatch_once( &once, ^{
        instance = [[CustData alloc] init];
    });
    return instance;
}

+ (NSMutableDictionary *)getAccountInfo{
    return [CustData sharedInstance].accountInfo;
}

+ (BOOL)isLogined{
    return !([CustData sharedInstance].accountInfo == nil);
}
//获取当前__年月日
+ (NSString *)timeGet{
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    //int hour = (int)[dateComponent hour];
    //int minute = (int)[dateComponent minute];
    //int second = (int)[dateComponent second];
    
    /* NSLog(@"year is: %d", year);
     NSLog(@"month is: %d", month);
     NSLog(@"day is: %d", day);
     NSLog(@"hour is: %d", hour);
     NSLog(@"minute is: %d", minute);
     NSLog(@"second is: %d", second);*/
    return [NSString stringWithFormat:@"%i年%i月%i日",year,month,day];
}

+(NSString *)getTokenByChecked{
    NSString * token;
    if([[ACache cache] getAsNSData:@"panchan_token"].length > 0){
        token = [[ACache cache] getAsNSString:@"panchan_token"];
    }else{
        token = @"1234567890";
    }
    return token;
}

+(NSString*)phoneNumHidePart:(NSString*)phoneNum;
{
    NSString * first = [phoneNum substringToIndex:3];
    NSString * middle = @"****";
    NSString * last = [phoneNum substringFromIndex:7];
    NSString * check = [NSString stringWithFormat:@"%@%@%@",first,middle,last];
    return check;
}

+ (NSString*)IDNumHidePart:(NSString*)IDStr{
    NSString * first = [IDStr substringToIndex:3];
    NSUInteger idlengthLast = IDStr.length - 4;
    NSString * last = [IDStr substringFromIndex:idlengthLast];
    NSUInteger middleLength = IDStr.length - 7;
    NSString * middleStr =@"";
    for(int i=0;i<middleLength;i++){
        middleStr = [middleStr stringByAppendingString:@"*"];
    }
    NSString * backStr = [NSString stringWithFormat:@"%@%@%@",first,middleStr,last];
    return backStr;
}

+(NSString*)formatBankCardLast4Num:(NSString*)sourceString{
    if(sourceString.length<=4){
        return sourceString;
    }
    NSInteger length = sourceString.length-4;
    NSString * returnString = [sourceString substringFromIndex:length];
    return returnString;
}

+ (NSString*)getInputTimesTamp{
    NSTimeInterval time_1970=[[NSDate date] timeIntervalSince1970] * 1000 ;
    double sysx = time_1970;
    NSNumber * numStage =  [NSNumber numberWithDouble:sysx];
    NSString * numStr = [NSString stringWithFormat:@"%0.0lf",[numStage doubleValue]];
    double sysTime = [numStr doubleValue];
    NSString * lessStr = [[ACache cache] getAsNSString:@"timestamp"];
    double less = [lessStr doubleValue];
    sysTime = sysTime + less;
    NSString * backSysTime = [NSString stringWithFormat:@"%0.0lf",sysTime];
    return backSysTime;
}

+(int)getRandomNumber:(int)from to:(int)to;
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (NSString*) md5ChangedWith:(NSString*)sourceStr{
    const char *cStr = [sourceStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash uppercaseString];
}

+(void)setImageFromUrl:(NSString *)urlString sourceImageView:(UIImageView *)imageView placeholderImage:(UIImage *)placeholderImage{
    [self setImageFromUrl:urlString sourceImageView:imageView placeholderImage:placeholderImage completion:nil];
}
+ (void) setImageFromUrl:(NSString*)urlString sourceImageView:(UIImageView*)imageView placeholderImage:(UIImage *)placeholderImage
              completion:(void (^)(void))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = nil;
        NSData *data = [[MemCache cache] readForKey:urlString];  //读取内存缓存数据
        if (data == nil) {   //请求网络数据
            //对中文和一些特殊字符编码
             NSString *urlStrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlStrl];
            data = [NSData dataWithContentsOfURL:url];
            
            if (data != nil)  //把数据写入内存缓存
                [[MemCache cache] write:data forKey:urlString];
        }
        img = [UIImage imageWithData:data];
        if (img) {
            dispatch_async(dispatch_get_main_queue(), ^{      //交给主线程更新UI
                imageView.image = img;
            });
        }else {  //如果网络数据未能下载成功，则用默认图片
            dispatch_async(dispatch_get_main_queue(), ^{      //交给主线程更新UI
                imageView.image = placeholderImage;
            });
        }
    });
    
}

+(BOOL)isUserName:(NSString*)userName{
    
    //    NSString *   regex = @"(^[u4e00-u9fa5],{0,20}$)";//只验证汉字
    NSString *   regex = @"^[\u4E00-\u9FA5]*$";//只验证汉字
    
    //    NSString *   regex = @"(/^\s*[\u4e00-\u9fa5]{1,}[\u4e00-\u9fa5.·]{0,15}[\u4e00-\u9fa5]{1,}\s*$/)";
    
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:userName];
}

+ (NSString *)trimByString:(NSString*)tempString{
    NSString *result = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return result;
}

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

+ (CGSize)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font byString:(NSString*)sourceString{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [sourceString boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

+(void)clearDataWithDismissView{
    if([[ACache cache] getAsNSData:@"panchan_token"].length>0){
        [[ACache cache] deleteCacheWithKey:@"panchan_token"];
    }
    if([[ACache cache] getAsNSData:@"timestamp"].length>0){
        [[ACache cache] deleteCacheWithKey:@"timestamp"];
    }
    if([CustData sharedInstance].accountInfo){
        [CustData sharedInstance].accountInfo = nil;
    }
}

+ (BOOL)onlyContainNumWithUItextField:(UITextField *)txtField InRange:(NSRange)range replacementString:(NSString *)string limitLength:(NSUInteger)length{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:isCheckNum]invertedSet];
    NSString *inputString = [txtField.text stringByAppendingString:string];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL basicTest = [string isEqualToString:filtered];
    //判断是否是输入纯数字
    if(!basicTest){
        return NO;
    }
    //判断是否超出要求的长度
    if (inputString.length > length) {
        return NO;
    }
    
    return YES;
}

+ (NSString *)getAPP_UDID{
    return [OpenUDIDPanChan value];
}

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
        return nil;
    }
    return dic;
}

+ (BOOL)checkBankCardNo:(NSString*)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


+ (NSString *)modifyIdCardxToX:(NSString *)idCard{
    return [idCard hasSuffix:@"x"] ? [idCard stringByReplacingOccurrencesOfString:@"x" withString:@"X"]:idCard;
}


+ (NSString *)  removeNonDigits             :(NSString *)string
                andPreserveCursorPosition   :(NSUInteger *)cursorPosition
{
    NSUInteger      originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd =
            [NSString stringWithCharacters:&characterToAdd
                                    length:1];
            
            [digitsOnlyString appendString:stringToAdd];
        } else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

+ (NSString *)  insertSpacesEveryFourDigitsIntoString   :(NSString *)string
                andPreserveCursorPosition               :(NSUInteger *)cursorPosition
{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger      cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        if ((i > 0) && ((i % 4) == 0)) {
            [stringWithAddedSpaces appendString:@" "];
            
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        
        unichar     characterToAdd = [string characterAtIndex:i];
        NSString    *stringToAdd =
        [NSString stringWithCharacters:&characterToAdd length:1];
        
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}

+ (BOOL)theDeviceCanUseApplePay{
    if ([PKPaymentAuthorizationViewController canMakePayments]) {
        return YES;
    }
    else{
        return NO;
    }
}
//获取token
+ (void)getTokenData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /*params[@"source"] = @"1";
    params[@"udid"] = [CustData getAPP_UDID];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    params[@"appVersion"] = version;
    params[@"pushDevice"] = @"";*/
    

    params[@"source"] = @"1";
    params[@"udid"] = [CustData getAPP_UDID];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    params[@"appVersion"] = version;
    params[@"pushDevice"] = [CustData sharedInstance].deviceToken;
    params[@"time"] = [TimeXLJ gettimestamp];
    NSLog(@"params = %@",params);

    [PayKit.kit post:@"/common/getToken" parameters:params completion:^(NSInteger errCode, id responseObject) {
        //NSLog(@"rrrrrrrrrrrr:%@",responseObject);
        if (errCode != 0) {
            NSString * resultError =  [UIHelper httpErrorCode:(int)errCode];
            if ([resultError isEqualToString:@""]) {
                [UIHelper alert:responseObject[@"resMsg"] completionBlock:^{
                    
                }];
            }else{
                [UIHelper alert:resultError completionBlock:^{
                    
                }];
            }
        
        }else{
            [[ACache cache] deleteCacheWithKey:@"panchan_token"];
            [[ACache cache] put:@"panchan_token" string:[NSString stringWithFormat:@"%@",[responseObject[@"results"] objectForKey:@"token"]]];
        }
    }];
}

// 查询 服务器 时间
- (void)queryTimesTamp{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [PayKit.kit post:@"/common/getServerTimestamp" parameters:params completion:^(NSInteger errCode, id responseObject) {
        if (errCode!=0) {
            if(errCode == -1004){
                [UIHelper alert:responseObject[@"resMsg"] completionBlock:nil];
            }else{
                [UIHelper alert:responseObject[@"resMsg"] completionBlock:nil];
            }
        }else{
            NSData * data = [[ACache cache] getAsNSData:@"timestamp"];
            if(data.length == 0){
                double backTime = [responseObject[@"timestamp"] doubleValue];
                NSTimeInterval time_1970=[[NSDate date] timeIntervalSince1970] * 1000 ;
                double sysx = time_1970;
                NSNumber * numStage =  [NSNumber numberWithDouble:sysx];
                NSString * numStr = [NSString stringWithFormat:@"%0.0lf",[numStage doubleValue]];
                double sysTime = [numStr doubleValue];
                double less = backTime - sysTime;
                [[ACache cache] put:@"timestamp" string:[NSString stringWithFormat:@"%f",less]];
                // 有效一个小时
                //[[ACache cache] put:@"timestamp" string:responseObject[@"timestamp"] timeout:60*60];
            }
        }
    }];
    
}


+ (NSString *)scannerNumberWithString:(NSString *)urlString{
    
    NSString *headstr;
    NSString *num;
    if (urlString.length > 4) {
        headstr = [urlString substringToIndex:3];
    }
    NSLog(@"headstr = %@",headstr);
    
    if ([headstr isEqualToString:@"闪客蜂"]) {
        NSScanner *scanner = [NSScanner scannerWithString:urlString];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        int number;
        [scanner scanInt:&number];
        num=[NSString stringWithFormat:@"%d",number];
        if (num.length == 5) {
            num = [NSString stringWithFormat:@"0%@",num];
        }
    }else{
        num = urlString;
    }
    
    return num;
}
/*******
 盘缠2.0新增
 */
//盘缠2.0登录密码规则:密码为6～16个数字、字母或符号的组合，不能是纯数字或纯字母
+ (BOOL)loginPasswordRule:(NSString *)password{
    //判断字符长度
    if (password.length < 6||password.length > 16||(password == nil) || ([password isEqualToString:@""]) ) {
        return NO;
    }
    //判断是否是纯数字
    NSScanner* scan = [NSScanner scannerWithString:password];
    int val;
    BOOL b = [scan scanInt:&val] && [scan isAtEnd];
    if (b) {
        return NO;
    }
    //判断是否是纯字母
    BOOL b1 = [CustData PureLetters:password];
    if (b1) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)PureLetters:(NSString*)str{
    
    for(int i=0;i<str.length;i++){
        
        unichar c=[str characterAtIndex:i];
        
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
            
            return NO;
        
    }
    
    return YES;
    
}

+ (void)authenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSString *method = challenge.protectionSpace.authenticationMethod;
    NSLog(@"%@", method);
    
    if([method isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        NSString *host = challenge.protectionSpace.host;
        NSLog(@"%@", host);
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        return;
    }
    
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
    SecIdentityRef identity;
    
    // 读取p12证书中的内容
    OSStatus result = [self extractP12Data:inPKCS12Data toIdentity:&identity];
    if(result != errSecSuccess){
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        return;
    }
    
    SecCertificateRef certificate = NULL;
    SecIdentityCopyCertificate (identity, &certificate);
    
    const void *certs[] = {certificate};
    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
    
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:(NSArray*)CFBridgingRelease(certArray) persistence:NSURLCredentialPersistencePermanent];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}

+ (OSStatus) extractP12Data:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {
    
    OSStatus securityError = errSecSuccess;
    
    CFStringRef password = CFSTR("the_password");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    
    if (options) {
        CFRelease(options);
    }
    
    return securityError;
}



@end
