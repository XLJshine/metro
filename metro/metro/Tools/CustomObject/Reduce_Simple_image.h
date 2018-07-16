//
//  Reduce_Simple_image.h
//  Lebang
//
//  Created by 熊良军 on 15/1/6.
//  Copyright (c) 2015年 熊良军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Reduce_Simple_image : NSObject
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//压缩图片尺寸并限制大小
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize data_Kb_Size:(CGFloat)dataMaxSize;
//压缩图片尺寸并限制大小
+ (NSData *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize data_Kb1_Size:(CGFloat)dataMaxSize;
//返回图片image大小
+ (CGFloat)returnImageDataSize_WithImage:(UIImage *)image;
//返回图片data大小
+ (CGFloat)returnImageDataSize_WithImageDate:(NSData *)imageData;
@end
