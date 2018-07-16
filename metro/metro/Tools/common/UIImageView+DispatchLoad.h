//
//  UIImageView+DispatchLoad.h
//  licai
//
//  Created by hxf on 15/7/27.
//
//

#import <UIKit/UIKit.h>
#import "MemCache.h"

@interface UIImageView (DispatchLoad)

- (void) setImageFromUrl:(NSString*)urlString placeholderImage:(UIImage *)placeholderImage;
- (void) setImageFromUrl:(NSString*)urlString placeholderImage:(UIImage *)placeholderImage
              completion:(void (^)(void))completion;

@end
