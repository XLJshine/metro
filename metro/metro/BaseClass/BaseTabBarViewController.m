//
//  BaseTabBarViewController.m
//  metro
//
//  Created by 熊良军 on 2018/7/12.
//  Copyright © 2018年 cssweb. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationController.h"

#import "SCMainViewController.h"
#import "AFMainViewController.h"
#import "CCMainViewController.h"
#import "SIMainViewController.h"
#import "PCMainViewController.h"

#import "MTTabBar.h"
@interface BaseTabBarViewController ()<MTTabBarDelegate>
@property (nonatomic,strong)MTTabBar *mttabBar;
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController];
    
    //添加中间按钮
    MTTabBar *tabBar = [[MTTabBar alloc] init];
    tabBar.mtTabBarDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    self.mttabBar = tabBar;
}
-(void)addButtonClick:(MTTabBar *)tabBar{
    NSLog(@"中间按钮点击");
    self.selectedIndex = 4;
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
    SCMainViewController *SCVC = [[SCMainViewController alloc] init];
    AFMainViewController *AFVC = [[AFMainViewController alloc] init];
    CCMainViewController *CCVC = [[CCMainViewController alloc] init];
    SIMainViewController *SIVC = [[SIMainViewController alloc] init];
    PCMainViewController *PCVC = [[PCMainViewController alloc] init];
    
    [self addChildViewController:SCVC title:@"地铁咨询" image:@"tabbar_btn_menu_n" selectImage:@"tabbar_btn_menu_s"];
    [self addChildViewController:AFVC title:@"失物招领" image:@"tabbar_btn_market_n" selectImage:@"tabbar_btn_market_s"];
    [self addChildViewController:SIVC title:@"站点信息" image:@"tabbar_btn_pdata_n" selectImage:@"tabbar_btn_pdata_s"];
    [self addChildViewController:PCVC title:@"个人中心" image:@"tabbar_btn_market_n" selectImage:@"tabbar_btn_market_s"];
    [self addChildViewController:CCVC title:@"乘车码" image:@"tabbar_btn_pdata_n" selectImage:@"tabbar_btn_pdata_s"];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (self.mttabBar.addButton.selected) {
        self.mttabBar.addButton.selected = !self.mttabBar.addButton.selected;
        self.mttabBar.addLabel.textColor = [UIColor grayColor];
    }

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
