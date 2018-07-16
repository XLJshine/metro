//
//  UIColorExchange16X_XLJ.h
//  时时投
//
//  Created by 熊良军 on 15/11/26.
//  Copyright © 2015年 yunjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
    top = 0,    //向上
    left = 1,   //向左
    right = 2,  //向右
    bottom = 3,  //向下
    topleft = 4,  //左上
    topright = 5, //右上
    bottomleft = 6, //下左
    bottomright = 7  //下右
}GradientDirection;
@interface UIColorExchange16X_XLJ : NSObject
//16进制转UIColor
+ (UIColor *) colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//UIColor转16进制
+ (NSString *) changeUIColorToRGB:(UIColor *)color;
//生成纯色图片（可以是半透明）
+ (UIImage *)imageWithBgColor:(UIColor *)color;
//画渐变图层：view父视图；frame坐标；colors颜色数组；locations渐变层的相对位置,起始点为0,终止点为1,中间点为 (point-startpoint)/(endpoint-startpoint)如：@[@0,@.5,@1]；direction渐变方向;cornerRadius圆角弧度
+ (void)drawGradientInSuperView:(UIView *)view frame:(CGRect)frame colors:(NSArray *)colors locations:(NSArray *)locations gradientDirection:(GradientDirection)direction cornerRadius:(CGFloat)cornerRadius;
@end
