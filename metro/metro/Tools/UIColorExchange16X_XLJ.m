//
//  UIColorExchange16X_XLJ.m
//  时时投
//
//  Created by 熊良军 on 15/11/26.
//  Copyright © 2015年 yunjie. All rights reserved.
//

#import "UIColorExchange16X_XLJ.h"
@implementation UIColorExchange16X_XLJ

+ (UIColor *) colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

//颜色转字符串
+ (NSString *) changeUIColorToRGB:(UIColor *)color{
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    NSString *r = [NSString stringWithFormat:@"%@",[UIColorExchange16X_XLJ  ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[UIColorExchange16X_XLJ  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[UIColorExchange16X_XLJ  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
}


//十进制转十六进制
+ (NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig = tmpid%16;
    int tmp = tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

+ (UIImage *)imageWithBgColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


+ (void)drawGradientInSuperView:(UIView *)view frame:(CGRect)frame colors:(NSArray *)colors locations:(NSArray *)locations gradientDirection:(GradientDirection)direction cornerRadius:(CGFloat)cornerRadius{
    CAGradientLayer *gradient = [CAGradientLayer layer];//创建渐变层
    gradient.frame = frame;
    if (cornerRadius) {
        gradient.masksToBounds = YES;
        gradient.cornerRadius = cornerRadius;
    }
    
    [view.layer addSublayer:gradient];
    //渐变层的颜色梯度数组
    NSMutableArray *colorMuArray = [NSMutableArray array];
    for (NSInteger i = 0;i < colors.count;i++) {
        UIColor *color = [colors objectAtIndex:i];
        if ([color isKindOfClass:[UIColor class]]) {
            [colorMuArray addObject:(__bridge id)color.CGColor];
        }
    }
    gradient.colors = colorMuArray;
    //渐变层的相对位置,起始点为0,终止点为1,中间点为 (point-startpoint)/(endpoint-startpoint)
    //gradient.locations = @[@0,@.5,@1];
    if (locations) {
        gradient.locations = locations;
    }
 
    //渐变方向
    switch (direction) {
        case top:
        {
            gradient.startPoint = CGPointMake(0, 1);
            gradient.endPoint = CGPointMake(0, 0);
        }
            break;
        case left:
        {
            gradient.startPoint = CGPointMake(1, 0);
            gradient.endPoint = CGPointMake(0, 0);
        }
            break;
        case right:
        {
            gradient.startPoint = CGPointMake(0, 0);
            gradient.endPoint = CGPointMake(1, 0);
        }
            break;
        case bottom:
        {
            gradient.startPoint = CGPointMake(0, 0);
            gradient.endPoint = CGPointMake(0, 1);
        }
            break;
        case topleft:
        {
            gradient.startPoint = CGPointMake(1, 1);
            gradient.endPoint = CGPointMake(0, 0);
        }
            break;
        case topright:
        {
            gradient.startPoint = CGPointMake(0, 1);
            gradient.endPoint = CGPointMake(1, 0);
        }
            break;
        case bottomleft:
        {
            gradient.startPoint = CGPointMake(1, 0);
            gradient.endPoint = CGPointMake(0, 1);
        }
            break;
        case bottomright:
        {
            gradient.startPoint = CGPointMake(0, 0);
            gradient.endPoint = CGPointMake(1, 1);
        }
            break;
        
        default:{  //默认向下
            gradient.startPoint = CGPointMake(0, 0);
            gradient.endPoint = CGPointMake(0, 1);
        }
            break;
    }
   
}


@end
