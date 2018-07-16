//
//  PanchanSureButton.m
//  PanChan_ProjectPods
//
//  Created by Cssweb888888 on 16/6/14.
//  Copyright © 2016年 北京中软万维上海分公司. All rights reserved.
//

#import "PanchanSureButton.h"
#import "UIImageWithColor.h"
@implementation PanchanSureButton
-  (instancetype)init{
    self = [super init];
    if (self) {
        [self consolidateStyle];
        [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title completion:(PanchanSureButtonBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        _block = block;
        [self consolidateStyle];
        [self setTitle:title forState:UIControlStateNormal];
        [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        [self consolidateStyle];
        
        [self setTitle:title forState:UIControlStateNormal];
       
    }
    
    return self;

}

- (void)consolidateStyle{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 7;
    [self setBackgroundImage:[UIImageWithColor imageWithBgColor:[UIColor colorWithRed:0.1098 green:0.4510 blue:0.8510 alpha:1.0]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImageWithColor imageWithBgColor:[UIColor colorWithRed:0.1098 green:0.4510 blue:0.8510 alpha:0.5]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



- (void)action:(UIButton *)button{
    _block(button.tag);
}


@end
