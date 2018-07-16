//
//  ScrollKit.m
//  licai
//
//  Created by hxf on 15/7/15.
//
//

#import "ScrollKit.h"

@implementation ScrollKit


+(ScrollKit *)scroll{
    static dispatch_once_t once;
    static ScrollKit *mInstance = nil;
    dispatch_once( &once, ^{ mInstance = [[ScrollKit alloc] init]; } );
    return mInstance;
}

#pragma mark -- 处理键盘显示
-(void)keyboardShowWithNotification:(NSNotification *)noti WithScrollView:(UIScrollView *)scrollView{
    if (self.isKeyboardShown) return;
    self.isKeyboardShown = TRUE;
    
    //找到第一响应者
    UITextField *txt = (UITextField *)[self findFirstResponderBeneathView:scrollView];
    if (txt == nil) return ;
    
    NSDictionary* info = [noti userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    
    // Resize the scroll view (which is the root view of the window)
    CGRect scrollFrame = scrollView.frame;
    CGRect viewFrame = scrollView.superview.frame;
    if (scrollFrame.size.height > viewFrame.size.height) {
        scrollFrame.size.height = viewFrame.size.height;
    }
    scrollFrame.size.height -= (keyboardSize.height);
    scrollView.frame = scrollFrame;
    
    // Scroll the active text field into view.
    CGRect textFieldRect = [txt frame];
    textFieldRect.origin.y += txt.superview.frame.origin.y;
    [scrollView scrollRectToVisible:textFieldRect animated:YES];
}

#pragma mark --处理键盘隐藏
-(void)keyboardHideWithNotification:(NSNotification *)noti WithScrollView:(UIScrollView *)scrollView{
    NSDictionary* info = [noti userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Reset the height of the scroll view to its original value
    CGRect scrollFrame = scrollView.frame;
    CGRect viewFrame = scrollView.superview.frame;
    if (scrollFrame.size.height > viewFrame.size.height) {
        scrollFrame.size.height = viewFrame.size.height;
    }
    scrollFrame.size.height += keyboardSize.height;
    scrollView.frame = scrollFrame;
    
    self.isKeyboardShown = FALSE;
}

#pragma mark 查找第一响应者
- (UIView *)findFirstResponderBeneathView:(UIView *)view {
    // 递归查找
    for (UIView *childView in view.subviews ) {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) {
            return childView;
        }
        UIView *result = [self findFirstResponderBeneathView:childView];
        if (result) {
            return result;
        }
    }
    return nil;
}



@end
