//
//  XLJActionsheetViewController.h
//  Panchan
//
//  Created by Cssweb888888 on 16/5/25.
//  Copyright © 2016年 cssweb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    action,
    cancel,
}ActionType;
typedef void (^ActionsheetBlock)(ActionType type,NSInteger index);
@interface XLJActionsheetViewController : UIViewController
@property (nonatomic,strong)ActionsheetBlock actionBlock;
@property (nonatomic,strong)ActionsheetBlock cancelBlock;
- (instancetype)initWithTitleArray:(NSArray *)titleArr cancelString:(NSString *)cancelStr action:(ActionsheetBlock)actionBlock cancel:(ActionsheetBlock)cancelBlock;
@end
