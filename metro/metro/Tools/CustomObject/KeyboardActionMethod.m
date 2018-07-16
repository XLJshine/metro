//
//  KeyboardActionMethod.m
//  SchoolCard_Students
//
//  Created by cssweb on 15/11/25.
//  Copyright (c) 2015年 北京中软万维上海分公司. All rights reserved.
//

#import "KeyboardActionMethod.h"

@implementation KeyboardActionMethod

#pragma mark - UIView 键盘 弹 收 方法
+(void)keyboardShowActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndKeyboardNotification:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyboardHeight;
    if(keyboardRect.size.width < keyboardRect.size.height){
        keyboardHeight = keyboardRect.size.width;
    }else{
        keyboardHeight = keyboardRect.size.height;
    }
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGFloat keybordY = view.bounds.size.height - keyboardHeight;
    
    if(view.bounds.size.height > 568){
        viewUnderY = viewUnderY + 64;
    }
    if(keybordY <= viewUnderY){
        CGRect viewRect = view.bounds;
        viewRect.origin.y = viewRect.origin.y - (viewUnderY-keybordY)-10;
        
        [UIView animateWithDuration:animationDuration animations:^{
            view.frame = viewRect;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

+(void)keyboardHiddenActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndKeyboardNotification:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyboardHeight;
    if(keyboardRect.size.width < keyboardRect.size.height){
        keyboardHeight = keyboardRect.size.width;
    }else{
        keyboardHeight = keyboardRect.size.height;
    }
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGFloat keybordY = view.bounds.size.height - keyboardHeight;
    
    if(view.bounds.size.height > 568){
        viewUnderY = viewUnderY + 64;
    }
    if(keybordY <= viewUnderY){
        [UIView animateWithDuration:animationDuration animations:^{
            view.frame = view.bounds;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

#pragma mark - UIScrollView 键盘 弹 收 方法
+(void)keyboardShowActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndSuperScrollView:(UIScrollView*)scrollView AndKeyboardNotification:(NSNotification *)noti{
    
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyboardHeight;
    if(keyboardRect.size.width < keyboardRect.size.height){
        keyboardHeight = keyboardRect.size.width;
    }else{
        keyboardHeight = keyboardRect.size.height;
    }
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGFloat keybordY = view.bounds.size.height - keyboardHeight;
    
    if(view.bounds.size.height > 568){
        viewUnderY = viewUnderY + 64;
    }
    if(keybordY < viewUnderY){
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, viewUnderY  + keyboardHeight + 10);
        
        [UIView animateWithDuration:animationDuration animations:^{
            float x = 0.0;//偏移量
            if(view.bounds.size.height > 568){
                x = 50;
            }
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - view.bounds.size.height - x);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

+(void)keyboardHiddenActionWithViewUnderY:(float)viewUnderY AndSuperView:(UIView*)view AndSuperScrollView:(UIScrollView*)scrollView AndScrollViewContentSizeHeight:(float)contentSizeHeight AndKeyboardNotification:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyboardHeight;
    if(keyboardRect.size.width < keyboardRect.size.height){
        keyboardHeight = keyboardRect.size.width;
    }else{
        keyboardHeight = keyboardRect.size.height;
    }
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGFloat keybordY = view.bounds.size.height - keyboardHeight;
    if(view.bounds.size.height > 568){
        viewUnderY = viewUnderY + 64;
    }
    
    if(keybordY < viewUnderY){
        NSLog(@"ttttttttttt:%f",contentSizeHeight);
        [UIView animateWithDuration:animationDuration animations:^{
            
            scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, contentSizeHeight);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
@end
