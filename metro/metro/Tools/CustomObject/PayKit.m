//
//  ToolKit.m
//  licai
//
//  Created by cssweb on 14-11-24.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import "PayKit.h"
#import "CWHttpClientKit.h"
#import "CustData.h"
#import "EncryptionPanChan.h"
#import "TimeXLJ.h"
@implementation PayKit

+ (NSDictionary *)signParams:(NSDictionary *)params WithToken:(BOOL)token;
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:params];
//    result[@"sysUID"] = @"01";
    result[@"udid"] = [CustData getAPP_UDID];
    
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    result[@"appVersion"] = version;
    
//    result[@"timestamp"] = [CustData getInputTimesTamp];
    NSTimeInterval time_1970=[[NSDate date] timeIntervalSince1970] * 1000;
    double sysx = time_1970;
    NSNumber * numStage =  [NSNumber numberWithDouble:sysx];
    NSString * numStr = [NSString stringWithFormat:@"%0.0lf",[numStage doubleValue]];
    result[@"time"] = [NSString stringWithFormat:@"%@",numStr];
    
    if(token == YES){
       result[@"token"] = [CustData getTokenByChecked];
    }
    
    result[@"source"] = @"1";
    result[@"time"] = [TimeXLJ gettimestamp];
    //result[@"token"] = [CustData getTokenByChecked];
    result[@"udid"] =  [CustData getAPP_UDID];
    //result[@"sign"] =  @"111";
    //登录密码
    if(result[@"loginPwd"]){
        NSString * tempPassword = result[@"loginPwd"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"loginPwd"] = encryStr;
    }
//原登录密码
    if(result[@"oldLoginPwd"]){
        NSString * tempPassword = result[@"oldLoginPwd"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"oldLoginPwd"] = encryStr;
    }
//新登录密码
    if(result[@"newLoginPwd"]){
        NSString * tempPassword = result[@"newLoginPwd"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"newLoginPwd"] = encryStr;
    }
//交易密码
    if(result[@"tradePWd"]){
        NSString * tempPassword = result[@"tradePWD"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"tradePWD"] = encryStr;
    }
//交易密码2
    if(result[@"tradePwd"]){
        NSString * tempPassword = result[@"tradePwd"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"tradePwd"] = encryStr;
    }
//原交易密码
    if(result[@"oldTradePwd"]){
        NSString * tempPassword = result[@"oldTradePwd"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"oldTradePwd"] = encryStr;
    }
//新交易密码
    if(result[@"newTradePwd"]){
        NSString * tempPassword = result[@"newTradePwd"];
        NSData * encryData = [EncryptionPanChan AES128Encrypt:tempPassword key:Encry_Key];
        NSString * encryStr = [EncryptionPanChan hexStringFromData:encryData];
        result[@"newTradePwd"] = encryStr;
    }

    //NSLog(@"result = %@",result);
    
    return result;
}

+ (NSDictionary *)signParamsByQueryTime:(NSDictionary *)params;
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:params];
    result[@"sysUID"] = @"01";
    result[@"udid"] = [CustData getAPP_UDID];
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    result[@"appVersion"] = version;
    
    return result;
}

- (void)post:(NSString *)urlname
  parameters:(NSDictionary *)parameters
  completion:(PayKitCompletion)completion;
{
    PayKit.kit.serverUrl = @"http://expo.cssweb.sh.cn"; //开发环境
    
    
   
    NSString *urlstr = [_serverUrl stringByAppendingPathComponent:urlname];
    
    NSString * head = [urlname substringToIndex:4];
    if ([head isEqualToString:@"http"]) {
        urlstr = urlname;
        [CWHttpClientKit.kit post:urlstr parameters:parameters completion:^(AFHTTPRequestOperationPanChan *oper, id responseObject) {
                NSDictionary * res = [CustData dictionaryWithJsonString:oper.responseString];
                completion(200, res);
            }];
    }
    NSDictionary *params;
    //如果是查询时间接口的话 不需要传timestamp
    //NSLog(@"parameters1 = %@",parameters);
    
    if([urlname isEqualToString:@"/common/getServerTimestamp"]){
        params = [PayKit signParamsByQueryTime:parameters];
    }else if ([urlname isEqualToString:@"/common/getToken"]){
        params = parameters;
    }else if ([urlname isEqualToString:@"/account/getUserInfoByToken"]){
        params = [PayKit signParams:parameters WithToken:NO];
    }else if ([urlname isEqualToString:@"/account/checkAccountExits"]){
        params = [PayKit signParams:parameters WithToken:NO];
    }else{
        params = [PayKit signParams:parameters WithToken:YES];
       
    }
    //NSLog(@"params1 = %@",params);
    
     NSString * sub5 = [urlstr substringToIndex:5];
    if([sub5 isEqualToString:@"http:"]){
        [CWHttpClientKit.kit post:urlstr parameters:params completion:^(AFHTTPRequestOperationPanChan *oper, id responseObject) {
            if (oper.error) {
                NSString * msg = @"";
                if(oper.error.code == -1004){
                    msg = @"网络异常!";
                    completion(-1004, @{@"resMsg":msg});
                }else{
                    //msg = @"网络异常，请检查网络设置，或稍后再试";
                    msg = [NSString stringWithFormat:@"系统内部错误%@",oper.error.description];
                    completion(500, @{@"resMsg":msg});
                }
            }else{
                NSDictionary * res = [CustData dictionaryWithJsonString:oper.responseString];
                NSInteger code;
                if (res==nil) {
                    code = 900;
                    res = @{@"resMsg":@"json数据格式错误"};
                }else if([res[@"resCode"] isKindOfClass:[NSNull class]]){
                    code = 901;
                    res = @{@"resMsg":@"服务器数据错误"};
                }else{
                    code = [res[@"resCode"] integerValue];
                }
                completion(code,res);
            }
        }];

    }else if ([sub5 isEqualToString:@"https"]){
        [CWHttpClientKit.sslkit post:urlstr parameters:params completion:^(AFHTTPRequestOperationPanChan *oper, id responseObject) {
            NSLog(@"responseObject:%@", oper.responseString);
            if (oper.error) {
                NSString * msg = @"";
                if(oper.error.code == -1004){
                    msg = @"网络异常!";
                    completion(-1004, @{@"resMsg":msg});
                }else{

                    msg = [NSString stringWithFormat:@"Code:%ld\n系统内部错误%@",(long)oper.error.code,oper.error.description];
                    //msg = @"网络异常，请检查网络设置，或稍后再试";
                    completion(500, @{@"resMsg":msg});
                }
                
            }else{
                NSDictionary * res = [CustData dictionaryWithJsonString:oper.responseString];
                NSInteger code;
                if (res==nil) {
                    code = 900;
                    res = @{@"resMsg":@"json数据格式错误"};
                }else if([res[@"resCode"] isKindOfClass:[NSNull class]]){
                    code = 901;
                    res = @{@"resMsg":@"服务器数据错误"};
                }else{
                    code = [res[@"resCode"] integerValue];
                }
                completion(code,res);
            }
        }];
    }
    
}

//单例对象
+ (PayKit *)kit;
{
    static PayKit *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PayKit alloc] init];
        _sharedClient.imageUrlTest = @"http://pic8.nipic.com/20100709/4752803_210430061441_2.jpg";
   });
    
    
    return _sharedClient;
}
@end
