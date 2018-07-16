//
//  Macro.h
//  Panchan
//
//  Created by LiuXinQi on 16/5/25.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//应用相关
#define SERVICE_TEL @"tel:400332412"



//屏幕大小
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_PRO SCREEN_WIDTH/320.0
//获取系统版本
#define IOS_VERSION [[UIDevice currentDevice] systemVersion].floatValue
#define CurrentSystemVersion ［UIDevice currentDevice] systemVersion]

//颜色相关
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define DotNumbers     @"0123456789.\n"
#define allowNumbers     @"0123456789\n"

#endif /* Macro_h */
