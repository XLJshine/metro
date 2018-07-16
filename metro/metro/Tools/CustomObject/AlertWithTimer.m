//
//  AlertWithTimer.m
//  licai
//
//  Created by hxf on 15/6/23.
//
//

#import "AlertWithTimer.h"

@implementation AlertWithTimer{
    NSTimer *alertTimer;
    NSInteger countTime;
    UIAlertView *alertView;
}


- (void)initAlertWithTime:(NSInteger)time Msg:(NSString *) message{
    countTime = time;
    [self destroyTimer];
//    NSString *show = [NSString stringWithFormat:@"%@(%lds)",message, (long)countTime];
    NSString *show = [NSString stringWithFormat:@"%@",message];
    alertTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissAlertView:) userInfo:message repeats:YES];
    
    alertView = [[UIAlertView alloc] initWithTitle:@"" message:show delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)dismissAlertView:(NSTimer *)timer{
    countTime--;
    if (countTime <= 0) {
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
    }else{
     //   NSString *show = [NSString stringWithFormat:@"%@(%lds)", [timer userInfo], (long)countTime];
        NSString *show = [NSString stringWithFormat:@"%@",[timer userInfo]];
        alertView.message = show;
    }
}

- (void)destroyTimer{
    if (alertTimer) {
        if ([alertTimer isValid]) {
            [alertTimer invalidate];
            alertTimer=nil;
        }
    }
    return ;
}

//单例对象
+ (AlertWithTimer*) alert;
{
    static dispatch_once_t once;
    static AlertWithTimer *mInstance = nil;
    dispatch_once( &once, ^{ mInstance = [[AlertWithTimer alloc] init]; } );
    return mInstance;
}


@end
