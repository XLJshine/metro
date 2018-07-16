//
//  ToolKit.h
//  licai
//
//  Created by cssweb on 14-11-24.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^PayKitCompletion)(NSInteger errCode, id responseObject);

@interface PayKit : NSObject

@property (nonatomic,strong) NSString *serverUrl;
@property (nonatomic,strong) NSString *imageUrlTest;
// 请求数据
- (void)post:(NSString *)urlname
  parameters:(NSDictionary *)parameters
  completion:(PayKitCompletion)completion;

//单例对象
+ (PayKit *)kit;
@end
