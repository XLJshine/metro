//
//  Cache.m
//  licai
//
//  Created by hxf on 15/7/19.
//
//

#import "MemCache.h"

@implementation MemCache

#pragma mark  --写缓存数据
-(void)write:(NSData*)data forKey:(NSString*)key{
    [self setObject:data forKey:key];
}

#pragma mark  --读缓存数据
-(NSData*)readForKey:(NSString*)key{
    return [self objectForKey:key];
}

#pragma mark --单例
+(MemCache *)cache{
    static dispatch_once_t once;
    static MemCache *mInstance = nil;
    dispatch_once( &once, ^{ mInstance = [[MemCache alloc] init]; } );
    return mInstance;
}


@end
