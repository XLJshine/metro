//
//  HttpRequest.m
//  PanChan_ProjectPods
//
//  Created by Cssweb888888 on 16/6/16.
//  Copyright © 2016年 北京中软万维上海分公司. All rights reserved.
//

#import "HttpRequest.h"


#define BOUNDARY @"----------cH2gL6ei4Ef1KM7cH2KM7ae0ei4gL6"

@implementation HttpRequest

+(id)upload:(NSString *)url widthParams:(NSDictionary *)params {
    
    NSError *err = nil;
    NSMutableURLRequest *myRequest = [ [NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    for(NSString *key in params) {
        id content = [params objectForKey:key];
        if ([content isKindOfClass:[NSString class]] || [content isKindOfClass:[NSNumber class]]) {
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",BOUNDARY,key,content,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
            
        } else if([content isKindOfClass:[FileDetail class]]) {
            
            FileDetail *file = (FileDetail *)content;
            
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",BOUNDARY,key,file.name,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file.data];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSString *endString = [NSString stringWithFormat:@"--%@--",BOUNDARY];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequest setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:myRequest returningResponse:nil error:&err];
    
    //NSLog(@"returnData = %@",returnData);
    NSString *aString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"aString = %@",aString);
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:returnData options:noErr error:nil];
    
    //NSLog(@"jsonObj = %@",jsonObj);
    
    return jsonObj;
}


@end


@implementation FileDetail
+ (FileDetail *)fileWithName:(NSString *)name data:(NSData *)data {
    FileDetail *file = [[self alloc] init];
    file.name = name;
    file.data = data;
    return file;
}
@end

