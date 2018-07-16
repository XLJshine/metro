//
//  UIImageView+DispatchLoad.m
//  licai
//
//  Created by hxf on 15/7/27.
//
//

#import "UIImageView+DispatchLoad.h"

@implementation UIImageView (DispatchLoad)

- (void) setImageFromUrl:(NSString*)urlString placeholderImage:(UIImage *)placeholderImage {
    [self setImageFromUrl:urlString placeholderImage:placeholderImage completion:NULL];
}


/*
 过程: 
 1.先从内存缓存中读取数据，
 2.如果内存缓存没有数据，则请求网络数据，同时把数据写入内存缓存（这里没有把数据保存到磁盘上）
 3.如果网络数据没有请求成功，则读取默认图片
 */
- (void) setImageFromUrl:(NSString*)urlString placeholderImage:(UIImage *)placeholderImage
              completion:(void (^)(void))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = nil;
        NSData *data = [[MemCache cache] readForKey:urlString];  //读取内存缓存数据
        if (data == nil) {   //请求网络数据
            // 对中文和一些特殊字符进行编码
            NSString *urlStrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlStrl];
            data = [NSData dataWithContentsOfURL:url];
            
            if (data != nil)  //把数据写入内存缓存
                [[MemCache cache] write:data forKey:urlString];
        }
        img = [UIImage imageWithData:data];
        if (img) {
            NSLog(@"-- already downloaded: %@", urlString);
            dispatch_async(dispatch_get_main_queue(), ^{      //交给主线程更新UI
                self.image = img;
            });
        }else {  //如果网络数据未能下载成功，则用默认图片
            NSLog(@"-- impossible download: %@", urlString);
            dispatch_async(dispatch_get_main_queue(), ^{      //交给主线程更新UI
                self.image = placeholderImage;
            });
        }
    });

}


@end
