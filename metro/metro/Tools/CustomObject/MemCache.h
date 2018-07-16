//
//  Cache.h
//  licai
//
//  Created by hxf on 15/7/19.
//
//

#import <Foundation/Foundation.h>

@interface MemCache : NSCache

#pragma mark  --写缓存数据
-(void)write:(NSData*)data forKey:(NSString*)key;

#pragma mark  --读缓存数据
-(NSData*)readForKey:(NSString*)key;

#pragma mark --单例
+(MemCache *)cache;

@end
