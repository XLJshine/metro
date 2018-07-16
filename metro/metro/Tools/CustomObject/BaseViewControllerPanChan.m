//
//  BaseViewController.m
//  licai
//
//  Created by cssweb on 14-11-19.
//  Copyright (c) 2014年 胡伟平. All rights reserved.
//

#import "BaseViewControllerPanChan.h"
#import "UIHelper.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"

//#import "FindPayPasswordTypeWay.h"

@interface BaseViewControllerPanChan ()
@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

@end

@implementation BaseViewControllerPanChan

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//状态栏白色

    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    
//    UIImage * backImage = [UIImage imageNamed:@"back"];
//    CGRect frame= CGRectMake(0, 0, backImage.size.width/2, backImage.size.height/2);
//    UIButton * imageButton = [[UIButton alloc] initWithFrame:frame];
//    [imageButton setBackgroundImage:backImage forState:UIControlStateNormal];
//    [imageButton addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
    
//    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
//    self.navigationItem.leftBarButtonItem = leftButton;

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     NSString * controller = NSStringFromClass([self class]);
     NSLog(@"viewWillAppearController = %@",controller);
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:253/255.0f green:161/255.0f blue:35/255.0f alpha:1.0f];
    //self.parentViewController.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSString * controller = NSStringFromClass([self class]);
    NSLog(@"viewDidDisappearController = %@",controller);
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resign:(UIView *)view{
    for (UIView *childView in view.subviews ) {
        if ([childView isKindOfClass:[UITextField class]] ) {
            [childView resignFirstResponder];
        }
        [self resign:childView];
    }
}

- (void)cornerButton:(UIButton *)button {
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6.0;
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
