//
//  CWHttpClientKit.h
//  WitnessAccounts
//
//  Created by 胡伟平 on 13-2-27.
//  Copyright (c) 2013年 cssweb. All rights reserved.
//

#import "AFHTTPRequestOperationPanChan.h"

typedef void (^CWHttpClientKitCompletion)(AFHTTPRequestOperationPanChan *oper, id responseObject);

@interface CWHttpClientKit : NSObject


//创建新对象
+ (CWHttpClientKit *)newkit;

//单例对象
+ (CWHttpClientKit *)kit;

//单例https对象
+ (CWHttpClientKit *)sslkit;

- (void)requestGet:(NSString*)urlstr
            target:(id)target
        completion:(SEL)completion
          userInfo:(id)userInfo;

- (void)cancelAllOperation;

- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
 completion:(CWHttpClientKitCompletion)completion;

- (void)post:(NSString *)urlstr
  parameters:(NSDictionary *)parameters
  completion:(CWHttpClientKitCompletion)completion;

@end
