/*
//  CWCacheCenter.h
//  
//  Created by huwp on 12-7-22.
//  Copyright (c) 2012年 北京中软万维上海分公司. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface ACache : NSObject


// 单实例
+ (ACache *) cache;

//创建临时目录
+ (NSString*)createTmpDictory:(NSString*)dictoryname;

//获取下一个工作日的某时某分
+ (NSDate*)getNextT:(NSInteger)hour minutes:(NSInteger)minutes;

//获取明天的某时某分
+ (NSDate*)getTomorrow:(NSInteger)hour minutes:(NSInteger)minutes;

// 获取缓存内容的文件信息
- (NSDictionary*)getCacheInfo:(NSString*)key;

// 缓存接口
- (void)put:(NSString*)key data:(NSData*)data;
- (void)put:(NSString*)key data:(NSData*)data timeout:(NSTimeInterval)time;

- (void)put:(NSString*)key string:(NSString*)data;
- (void)put:(NSString*)key string:(NSString *)data timeout:(NSTimeInterval)time;

- (void)put:(NSString*)key object:(id)object;
- (void)put:(NSString*)key object:(id)object timeout:(NSTimeInterval)time;

- (id)get:(NSString*)key;
- (id)get:(NSString*)key validate:(BOOL)validate;

- (id)getDecodeData:(NSString*)key;
- (NSData *)getAsNSData:(NSString*)key;
- (NSData *)getAsNSData:(NSString *)key validate:(BOOL)validate;

- (NSString *)getAsNSString:(NSString*)key;

//解压缩数据
+ (id)decodeObject:(NSData*)data;

//删除所有的缓存数据
- (void) deleteAllCacheAndInfo;
// 删除指定key 的缓存
- (void) deleteCacheWithKey:(NSString*)key;

//保存 赎回中 选择需要赎回的产品 字典
@property(nonatomic,strong)NSDictionary * redSelectProductDic;

//保存 换购中 选择已有的产品 字典
@property(nonatomic,strong)NSDictionary * mySelectProductDic;
//保存 换购中 选择想要换购的产品 字典
@property(nonatomic,strong)NSDictionary * wantToExchangeProductDic;
//保存 明细页面 选择的时间或产品 字典
@property(nonatomic,strong)NSDictionary * dateOrProductDic;

//交通模块 判断是否已经开通过城市
@property(nonatomic)BOOL didOpenCity;

//交通模块 保存已加载的页面底部按钮标题
@property (nonatomic) int currDownButtonTitleIndex;
@end
