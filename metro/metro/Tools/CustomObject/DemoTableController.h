//
//  DemoTableControllerViewController.h
//  FPPopoverDemo
//
//  Created by Alvise Susmel on 4/13/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DemoTableControllerDelegate <NSObject>
-(void)dismisView:(NSDictionary*)titleDict;
@end
@interface DemoTableController : UITableViewController
@property(nonatomic,assign)id<DemoTableControllerDelegate>delegate;
@property(nonatomic,strong) NSArray * dataArray;

@end
