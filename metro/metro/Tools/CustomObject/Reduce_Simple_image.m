//
//  Reduce_Simple_image.m
//  Lebang
//
//  Created by 熊良军 on 15/1/6.
//  Copyright (c) 2015年 熊良军. All rights reserved.
//

#import "Reduce_Simple_image.h"

@implementation Reduce_Simple_image
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
//压缩图片尺寸并限制大小
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize data_Kb_Size:(CGFloat)dataMaxSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    NSData *bigImageData = UIImageJPEGRepresentation(newImage, 1);
    NSString *sizeStr = [NSByteCountFormatter stringFromByteCount:bigImageData.length countStyle:NSByteCountFormatterCountStyleBinary];
    NSLog(@"%@", sizeStr);
    
    float f = (float)bigImageData.length/1024.0f;
    NSLog(@"f = %f",f);
    int x = 0;
    while (f > dataMaxSize&&x < 5) {
        newImage = [UIImage imageWithData:bigImageData];
        bigImageData = UIImageJPEGRepresentation(newImage, 0.99);
        f = (float)bigImageData.length/1024.0f;
        NSLog(@"f = %f",f);
        x ++ ;
    }
    return newImage;

}
//压缩图片尺寸并限制大小
+ (NSData *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize data_Kb1_Size:(CGFloat)dataMaxSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    NSData *bigImageData = UIImageJPEGRepresentation(newImage, 1);
    NSString *sizeStr = [NSByteCountFormatter stringFromByteCount:bigImageData.length countStyle:NSByteCountFormatterCountStyleBinary];
    NSLog(@"%@", sizeStr);
    
    float f = (float)bigImageData.length/1024.0f;
    NSLog(@"f = %f",f);
    int x = 0;
    while (f > dataMaxSize&&x < 5) {
        newImage = [UIImage imageWithData:bigImageData];
        bigImageData = UIImageJPEGRepresentation(newImage, 0.99);
        f = (float)bigImageData.length/1024.0f;
        NSLog(@"f = %f",f);
        x ++ ;
    }
    return bigImageData;
}
//返回图片image大小
+ (CGFloat)returnImageDataSize_WithImage:(UIImage *)image{
   NSData *bigImageData = UIImageJPEGRepresentation(image, 1);
    //NSString *sizeStr = [NSByteCountFormatter stringFromByteCount:bigImageData.length countStyle:NSByteCountFormatterCountStyleBinary];
   float f = (float)bigImageData.length/1024.0f;
   return f;
}
//返回图片data大小
+ (CGFloat)returnImageDataSize_WithImageDate:(NSData *)imageData{
   float f = (float)imageData.length/1024.0f;
   return f;
}
@end
