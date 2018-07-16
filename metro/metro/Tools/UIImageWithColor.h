//
//  UIImageWithColor.h
//  时时投
//
//  Created by 熊良军 on 16/4/11.
//  Copyright © 2016年 yunjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImageWithColor : NSObject
//根据颜色生成图片
+ (UIImage *)imageWithBgColor:(UIColor *)color;
@end
