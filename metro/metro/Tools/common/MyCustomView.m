//
//  MyCustomView.m
//  Panchan
//
//  Created by cssweb on 16/7/1.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#import "MyCustomView.h"

@implementation MyCustomView

- (void)drawRect:(CGRect)rect {
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.5].CGColor;
    self.layer.borderWidth = 1.0;
}

@end
