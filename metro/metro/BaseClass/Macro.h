//
//  Macro.h
//  Panchan
//
//  Created by LiuXinQi on 16/5/25.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//#define URL_HEADER  @"http://60.205.184.47:22/" //方刚的服务器
//#define URL_HEADER  @"http://192.168.2.19/"  //公司内网
#define URL_HEADER  @"http://192.168.1.104/"  //家庭内网

//获取安全区域的宏
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
//应用相关
#define SERVICE_TEL @"tel:400332412"

//屏幕大小
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_RATIO_6 SCREEN_WIDTH/375.0  //以iphone6为基础的比例系数
#define SCREEN_RATIO_5S SCREEN_WIDTH/320.0  //以iphone5s为基础的比例系数
#define SCREEN_RATIO_6P SCREEN_WIDTH/414.0  //以iphone6P为基础的比例系数

//获取系统版本
#define IOS_VERSION [[UIDevice currentDevice] systemVersion].floatValue
#define CurrentSystemVersion ［UIDevice currentDevice] systemVersion]

//颜色相关
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define DotNumbers     @"0123456789.\n"
#define allowNumbers     @"0123456789\n"

#endif /* Macro_h */
