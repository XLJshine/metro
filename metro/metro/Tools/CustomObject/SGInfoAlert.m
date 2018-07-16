#import "SGInfoAlert.h"
#import "UIDraw.h"
#import "CustData.h"
@implementation SGInfoAlert


- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info showTime:(float)timeShow showType:(SGCharactersShowType) typeShow fontSize:(float)size{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = color;
        info_ = [[NSString alloc] initWithString:info];
        fontSize_ = frame.size;
        showTime = timeShow;
        showType = typeShow;
        sizeFont = size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    NSValue *valRect = [NSValue valueWithCGRect:rect];
    NSNumber *fontSize = [NSNumber numberWithFloat:sizeFont];
    NSValue *bgColor = [NSValue valueWithBytes:&bgcolor_ objCType:@encode(CGColorRef)];
    
    
    NSDictionary *dict = @{@"rectDraw":valRect, @"fontSize":fontSize, @"strShow":info_,
                           @"bgColor":bgColor};
    if (showType == charactersInCircle) {
        [UIDraw drawCharacterInCircle:dict];
    }else if(showType == charactersInRectangle){
        [UIDraw drawCharacterInRectangle:dict];
    }
   

}

- (void)dealloc{
  //  infoAlert = nil;
 //   [info_ release];
 //   [super dealloc];
}

// 从上层视图移除并释放
- (void)remove{
    [self removeFromSuperview];
}

// 渐变消失
- (void)fadeAway{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:showTime];
}

- (void)showInfo:(NSString *)info
         bgColor:(CGColorRef)color
          inView:(UIView *)view 
        vertical:(float)height
        showTime:(float)timeShow
        showType:(SGCharactersShowType)type
        fontSize:(float)sizeFont{
    
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    CGRect frame;
    //string 的 size
    CGSize size = [CustData boundingRectWithSize:CGSizeMake(view.frame.size.width*0.6, 400) andFont:[UIFont systemFontOfSize:sizeFont] byString:info];

    //view 的rect
    if (type == charactersInCircle) {
        int diameter = MAX(size.height, size.width)*1.2;
        frame = CGRectMake(0, 0, diameter, diameter);
    }else if (type == charactersInRectangle){
        frame = CGRectMake(0, 0, size.width+offsetWidth, size.height+offsetHeight);
    }
    if (infoAlert != nil)
        infoAlert.alpha = .0;
    
    infoAlert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info showTime:timeShow showType:type fontSize:sizeFont];
    if (type == charactersInCircle)
        infoAlert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    else if(type == charactersInRectangle)
        infoAlert.center = CGPointMake(view.center.x, view.frame.size.height*0.9);
    
    //alpha:  0------->0.7
    infoAlert.alpha = 0;
    [view addSubview:infoAlert];
    [view bringSubviewToFront:infoAlert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    
    if (type == charactersInRectangle) {
        infoAlert.center = CGPointMake(view.center.x, view.frame.size.height*height);
        infoAlert.alpha = 0.7;
    }else if(type == charactersInCircle){
        infoAlert.alpha = 1.0;
    }
    [UIView commitAnimations];
    [infoAlert performSelector:@selector(fadeAway) withObject:nil afterDelay:timeShow];
}

//单例
+(SGInfoAlert *)alert{
    static dispatch_once_t once;
    static SGInfoAlert *mInstance = nil;
    dispatch_once( &once, ^{ mInstance = [[SGInfoAlert alloc] init]; } );
    return mInstance;
}

@end
