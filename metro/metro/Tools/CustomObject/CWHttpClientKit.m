//
//  CWHttpClientKit.m
//  WitnessAccounts
//
//  Created by 胡伟平 on 13-2-27.
//  Copyright (c) 2013年 cssweb. All rights reserved.
//

#import "CWHttpClientKit.h"
#import "AFHTTPRequestOperationManagerPanChan.h"

@interface CWHttpClientKit()
{
    AFHTTPRequestOperationManagerPanChan *_manager;
}

@end


@implementation CWHttpClientKit

- (id)init;
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManagerPanChan manager];
        // _manager.requestSerializer.timeoutInterval = 10; //设置时间网络请求时间

    }
    return self;
}

//创建新对象
+ (CWHttpClientKit *)newkit;
{
    return [[CWHttpClientKit alloc] init];
}

//单例对象
+ (CWHttpClientKit *)kit;
{
    static CWHttpClientKit *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CWHttpClientKit alloc] init];
    });
    
    return _sharedClient;
}

//单例https对象
+ (CWHttpClientKit *)sslkit;
{
    static CWHttpClientKit *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CWHttpClientKit alloc] init];
        [_sharedClient supportSSL:YES];
    });
    
    return _sharedClient;
}

- (void)supportSSL:(BOOL)bol;
{
    if (bol) {
        AFSecurityPolicyPanChan *securityPolicy = [AFSecurityPolicyPanChan defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        
        _manager.securityPolicy = securityPolicy;
    }
}

- (void)excuteWithTarget:(id)target method:(SEL)method withObject:(id)obj withObject:(id)obj2;
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    dispatch_block_t block = ^{
        
        [target performSelector:method withObject:obj withObject:obj2];
    };
    
    block();
#pragma clang diagnostic pop
}

- (void)requestGet:(NSString*)urlstr
            target:(id)target
        completion:(SEL)completion
          userInfo:(id)userInfo;
{
    __block id sender = target;
    __block CWHttpClientKit *kit = self;
    
    [_manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperationPanChan *oper, id responseObject) {
        if (!oper.isCancelled) {
            [kit excuteWithTarget:sender method:completion withObject:oper withObject:responseObject];
        }
    } failure:^(AFHTTPRequestOperationPanChan *oper, NSError *error) {
        [kit excuteWithTarget:sender method:completion withObject:oper withObject:nil];
    }];
}

- (void)get:(NSString *)urlstr
 parameters:(NSDictionary *)parameters
 completion:(CWHttpClientKitCompletion)completion
{
    _manager.responseSerializer = [AFHTTPResponseSerializerPanChan serializer];
    [_manager GET:urlstr parameters:parameters success:^(AFHTTPRequestOperationPanChan *oper, id responseObject) {
        if (!oper.isCancelled) {
            completion(oper, responseObject);
        }
    } failure:^(AFHTTPRequestOperationPanChan *oper, NSError *error) {
        completion(oper, nil);
    }];
}

- (void)post:(NSString *)urlstr
  parameters:(NSDictionary *)parameters
  completion:(CWHttpClientKitCompletion)completion
{
    
    _manager.responseSerializer = [AFHTTPResponseSerializerPanChan serializer];
    [_manager.requestSerializer setTimeoutInterval:40];
    [_manager POST:urlstr parameters:parameters success:^(AFHTTPRequestOperationPanChan *operation, id responseObject) {
        if (!operation.isCancelled) {
            completion(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperationPanChan *operation, NSError *error) {
        completion(operation, nil);
    }];
}

- (void)cancelAllOperation;
{
    [_manager.operationQueue cancelAllOperations];
}

@end
