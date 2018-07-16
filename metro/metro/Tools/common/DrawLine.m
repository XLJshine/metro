//
//  DrawLine.m
//  XIB集训
//
//  Created by 熊良军 on 16/3/15.
//  Copyright © 2016年 yunjie. All rights reserved.
//

#import "DrawLine.h"

@implementation DrawLine
#pragma mark -- 画虚线（直线）
+ (void)draw_xu_LineInView:(UIView *)view startPoint:(CGPoint)point1 endPoint:(CGPoint)point2{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point1.x, point1.y);
    CGPathAddLineToPoint(path, NULL, point2.x,point2.y);
    
    // Setup the path
    //  CGMutablePathRef path = CGPathCreateMutable();
    // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y
    //CGPathMoveToPoint(path, NULL, 0, 10);
    //CGPathAddLineToPoint(path, NULL, 320,10);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[view layer] addSublayer:shapeLayer];
}
#pragma mark -- 画虚线（框）
+ (void)draw_xuKuang_LineInView:(UIView *)view{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor];
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    border.frame = view.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [view.layer addSublayer:border];

}

#pragma mark -- 画虚线（圆）
+ (void)draw_xuYuan_LineInView:(UIView *)view  rectmake:(CGRect)rect{
    CAShapeLayer *line =  [CAShapeLayer layer];
    CGMutablePathRef   path =  CGPathCreateMutable();
    
    line.lineWidth = 1.0f ;
    line.strokeColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f].CGColor;
    line.fillColor = [UIColor clearColor].CGColor;
    //line.lineDashPhase = 3.0;
    line.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat:3.0],[NSNumber numberWithFloat:2.0], nil];
    CGPathAddEllipseInRect(path, nil, rect);
                           line.path = path;
                           CGPathRelease(path);
                           [view.layer addSublayer:line];

}
@end
