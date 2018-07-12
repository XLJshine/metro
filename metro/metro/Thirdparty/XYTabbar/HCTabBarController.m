//
//  HCTabBarController.m
//  jcarea
//
//  Created by 王文 on 2016/12/13.
//  Copyright © 2016年 com.jcarea. All rights reserved.
//

#import "HCTabBarController.h"
//#import "HCNavigationController.h"
#import "BaseNavigationController.h"

@interface HCTabBarController ()//<HCTabBarDelegate>
//@property (strong, nonatomic) UIVisualEffectView *visualEffectView;

@end

@implementation HCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController];
    /*
     //添加中间按钮
    HCTabBar *tabBar = [[HCTabBar alloc] init];
    tabBar.centerDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
     */
}

/*
//MARK:代理
- (void)clTabBarCenterButtonClickStart:(HCTabBar *)tabBar centerMenu:(AwesomeMenu *)centerMenu {
    //毛玻璃
    UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    self.visualEffectView = visualEffectView;
    [visualEffectView setFrame:self.view.bounds];
    [self.view insertSubview:visualEffectView belowSubview:tabBar];
    
//    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    coverView.backgroundColor = [UIColor blackColor];
//    [self.view insertSubview:coverView belowSubview:tabBar];
}

- (void)clTabBarCenterButtonClickClose:(HCTabBar *)tabBar centerMenu:(AwesomeMenu *)centerMenu {
    [self.visualEffectView removeFromSuperview];
}
*/

-(void)addChildViewController:(UIViewController *)childController
                        title:(NSString *)title
                        image:(NSString *)image
                  selectImage:(NSString *)selectImage
{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [childController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
   
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}
- (void)addChildViewController {
    UIViewController *CVC = [[UIViewController alloc] init];
    UIViewController *SVC = [[UIViewController alloc] init];
    UIViewController *PVC = [[UIViewController alloc] init];
    //
   
    CVC.view.backgroundColor = [UIColor redColor];
    SVC.view.backgroundColor = [UIColor orangeColor];
    PVC.view.backgroundColor = [UIColor whiteColor];
    
   
    [self addChildViewController:CVC title:@"社区" image:@"tabbar_btn_menu_n" selectImage:@"tabbar_btn_menu_s"];
    [self addChildViewController:SVC title:@"商城" image:@"tabbar_btn_market_n" selectImage:@"tabbar_btn_market_s"];
    [self addChildViewController:PVC title:@"个人" image:@"tabbar_btn_pdata_n" selectImage:@"tabbar_btn_pdata_s"];
    
}

@end
