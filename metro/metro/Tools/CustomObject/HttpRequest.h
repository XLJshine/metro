//
//  HttpRequest.h
//  PanChan_ProjectPods
//
//  Created by Cssweb888888 on 16/6/16.
//  Copyright © 2016年 北京中软万维上海分公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+(id)upload:(NSString *)url widthParams:(NSDictionary *)params;

@end

@interface FileDetail : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSData *data;
+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data;
@end
