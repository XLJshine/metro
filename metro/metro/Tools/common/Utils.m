//
//  Utils.m
//  licai
//
//  Created by hxf on 15/7/15.
//
//

#import "Utils.h"

// 状态栏的高度
CGFloat UtilStatusBarHeight(){
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}
