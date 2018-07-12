//
//  BaseTabBarViewController.m
//  metro
//
//  Created by 熊良军 on 2018/7/12.
//  Copyright © 2018年 cssweb. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController];
    
}


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
