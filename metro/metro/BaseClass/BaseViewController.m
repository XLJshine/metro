//
//  BaseViewController.m
//  AdultCommunity
//
//  Created by 熊良军 on 2017/8/9.
//  Copyright © 2017年 xionglj. All rights reserved.
//

#import "BaseViewController.h"
#import "Macro.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
- (void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"SCREEN_HEIGHT = %f",SCREEN_HEIGHT);
   
    
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
