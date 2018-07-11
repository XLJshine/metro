//
//  BaseNavigationController.m
//  MicroTown
//
//  Created by microtown on 16/4/8.
//  Copyright © 2016年 Microtown  微镇商票宝. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //导航栏字体颜色
    NSDictionary *titleTextAttributes = @{
                                          NSForegroundColorAttributeName:[UIColor blackColor]
                                          };
    self.navigationBar.titleTextAttributes = titleTextAttributes;
    self.navigationBar.tintColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    
    //设置导航栏背景
//    self.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.navigationBar.translucent = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    
    //自定义返回按钮
    UIImage *backButtonImage = [UIImage imageNamed:@"common_nav_back_n.png"];
    backButtonImage = [backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonImage.size.width, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示   “使用该方法，APP间切换时，跳回自己的app会闪动，解决方法：在BaseViewController中去除返回的文字”
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    // 意思是，我们任然可以重新在push控制器的viewDidLoad方法中设置导航栏的leftBarButtonItem，如果设置了就会覆盖在push方法中设置的“返回”按钮，因为 [super push....]会加载push的控制器执行viewDidLoad方法。
    [super pushViewController:viewController animated:animated];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
