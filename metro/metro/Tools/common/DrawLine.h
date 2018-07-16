//
//  DrawLine.h
//  XIB集训
//
//  Created by 熊良军 on 16/3/15.
//  Copyright © 2016年 yunjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface DrawLine : NSObject
/**画虚线（直线）
   view为要要添加线的视图
 */
+ (void)draw_xu_LineInView:(UIView *)view startPoint:(CGPoint)point1 endPoint:(CGPoint)point2;
//*画虚线（矩形框）
+ (void)draw_xuKuang_LineInView:(UIView *)view;
//*画虚线（圆）
+ (void)draw_xuYuan_LineInView:(UIView *)view  rectmake:(CGRect)rect;
@end
