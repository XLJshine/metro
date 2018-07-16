//
//  XLJActionsheetViewController.m
//  Panchan
//
//  Created by Cssweb888888 on 16/5/25.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#import "XLJActionsheetViewController.h"

@interface XLJActionsheetViewController ()
@property (nonatomic,strong)UIActionSheet *actionsheet;
@property (nonatomic,strong)NSMutableArray *titleArray;  //功能标题
@property (nonatomic,strong)NSString *cancelStr;   //取消按钮
@property (nonatomic,strong)UIImage *captureImage;
@end

@implementation XLJActionsheetViewController

- (instancetype)initWithTitleArray:(NSArray *)titleArr cancelString:(NSString *)cancelStr action:(ActionsheetBlock)actionBlock cancel:(ActionsheetBlock)cancelBlock{
    self = [super init];
    if (self) {
        _actionBlock = actionBlock;
        _cancelBlock = cancelBlock;
        _titleArray = [NSMutableArray arrayWithArray:titleArr];
        _cancelStr = cancelStr;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.view];
        [window bringSubviewToFront:self.view];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
     self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtaped)]];
    [self performSelector:@selector(addViews) withObject:nil afterDelay:0.25];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewtaped{
    _cancelBlock(cancel,0);
    [self dismissSelf];

}
- (void)dismissSelf{
    NSArray *subViews = self.view.subviews;
    for (UIView *view in subViews) {
        if (view.tag == 100) {
            CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
            CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
            [UIView animateWithDuration:0.25 animations:^{view.frame = CGRectMake(0.0, screenH, screenW, (_titleArray.count + 1) * 50 + 8);}];
            [self performSelector:@selector(removeSelfView) withObject:nil afterDelay:0.25];
        }
    }
}

- (void)removeSelfView{
     [self.view removeFromSuperview];
}
- (void)cancel:(UIButton *)button{
    _cancelBlock(cancel,button.tag);
    [self dismissSelf];
}

- (void)action:(UIButton *)button{
    _actionBlock(action,button.tag);
    [self dismissSelf];
}

- (void)addViews{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0.0, screenH, screenW, (_titleArray.count + 1) * 50 + 8)];
    view.tag = 100;
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:view];
    
    UIView *actionView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, screenW, 50 * _titleArray.count)];
    actionView.backgroundColor = [UIColor whiteColor];
    [view addSubview:actionView];
    
    for (NSInteger i = 0; i < _titleArray.count; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 50 * i, screenW, 50)];
        [button setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.0824 green:0.4745 blue:0.8275 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.0824 green:0.4745 blue:0.8275 alpha:0.5] forState:UIControlStateHighlighted];
        button.tag = i;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor clearColor]];
        [actionView addSubview:button];
    }
    
    for (NSInteger i = 0; i < _titleArray.count; i ++) {
        UIView *sepline = [[UIView alloc]initWithFrame:CGRectMake(0.0, 49 + 50*i, screenW, 1)];
        sepline.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [actionView addSubview:sepline];
    }
    
    UIView *cancelView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 50*_titleArray.count + 8, screenW, 50)];
    cancelView.backgroundColor = [UIColor whiteColor];
    [view addSubview:cancelView];
    
    if (_cancelStr.length == 0) {
        _cancelStr = @"取消";
    }
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, screenW, 50)];
    [button setTitle:_cancelStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.0824 green:0.4745 blue:0.8275 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.0824 green:0.4745 blue:0.8275 alpha:0.5] forState:UIControlStateHighlighted];
    button.tag = 0;
    [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [cancelView addSubview:button];
    
    UIView *sepline = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, screenW, 1)];
    sepline.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [cancelView addSubview:sepline];
    
    [UIView animateWithDuration:0.25 animations:^{view.frame = CGRectMake(0.0, screenH - ((_titleArray.count + 1) * 50 + 8), screenW, (_titleArray.count + 1) * 50 + 8);}];
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
