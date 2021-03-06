//
//  MTTabBar.m
//  metro
//
//  Created by 熊良军 on 2018/7/16.
//  Copyright © 2018年 cssweb. All rights reserved.
//

#import "MTTabBar.h"
#import "Macro.h"
#define AddButtonMargin 10

@implementation MTTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
         //创建中间“+”按钮
         UIButton *addBtn = [[UIButton alloc] init];
         //设置默认背景图片
         [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_btn_assets_n"] forState:UIControlStateNormal];
        //设置按下时背景图片
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_btn_assets_s"] forState:UIControlStateSelected];
         //添加响应事件
         [addBtn addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        //将按钮添加到TabBar
         [self addSubview:addBtn];

         self.addButton = addBtn;
        
        //[self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBtnDidClick)]];
     }
    return self;
}

//响应中间“+”按钮点击事件
-(void)addBtnDidClick
{
     if([self.mtTabBarDelegate respondsToSelector:@selector(addButtonClick:)])
     {
        [self.mtTabBarDelegate addButtonClick:self];
         if (!self.addButton.selected) {
             self.addButton.selected = !self.addButton.selected;
              self.addLabel.textColor = [UIColor orangeColor];
         }
     }
}

-(void)layoutSubviews
 {
     [super layoutSubviews];

     //去掉TabBar上部的横线
     for (UIView *view in self.subviews)
     {
         if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1)   //横线的高度为0.5
         {
             UIImageView *line = (UIImageView *)view;
             line.hidden = YES;
         }
     }

    
     //设置“+”按钮的大小为图片的大小
     CGFloat buttonW = self.addButton.currentBackgroundImage.size.width*2.5;
     CGFloat buttonH = self.addButton.currentBackgroundImage.size.height*2.5;
     self.addButton.frame = CGRectMake(self.center.x - buttonW*0.5, - 17.0,buttonW,buttonH);
     //设置“+”按钮的位置
     /*
     CGPoint centerPoint = self.center;
     self.addButton.center = CGPointMake(centerPoint.x, - 1 * AddButtonMargin);*/
     
     //创建并设置“+”按钮下方的文本为“添加”
     UILabel *addLbl = [[UILabel alloc] init];
     addLbl.text = @"乘车码";
     addLbl.font = [UIFont systemFontOfSize:10];
     addLbl.textColor = [UIColor grayColor];
     [addLbl sizeToFit];

     //设置“添加”label的位置
     CGFloat x =  self.addButton.center.x;
     CGPoint centerPoint1 = CGPointMake(x, CGRectGetMaxY(self.addButton.frame) + 0.5 * AddButtonMargin + 0.5);
     addLbl.center = centerPoint1;

     [self addSubview:addLbl];

     self.addLabel = addLbl;

     int btnIndex = 0;
     //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
     Class class = NSClassFromString(@"UITabBarButton");
     for (UIView *btn in self.subviews) {//遍历TabBar的子控件
         if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
             //每一个按钮的宽度等于TabBar的三分之一
             btn.frame = CGRectMake(SCREEN_WIDTH / 5.0 * btnIndex, btn.frame.origin.y, SCREEN_WIDTH / 5.0, btn.frame.size.height);
             btnIndex++;
             //如果索引是1(即“+”按钮)，直接让索引加一
             if (btnIndex == 2) {
                 btnIndex++;
             }

         }
     }
     //将“+”按钮放到视图层次最前面
     [self bringSubviewToFront:self.addButton];
 }

 //重写hitTest方法，去监听"+"按钮和“添加”标签的点击，目的是为了让凸出的部分点击也有反应
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

     //这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
     //self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
     //在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或“添加”标签上
     //是的话让“+”按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
     if (self.isHidden == NO)
     {

         //将当前TabBar的触摸点转换坐标系，转换到“+”按钮的身上，生成一个新的点
         CGPoint newA = [self convertPoint:point toView:self.addButton];
         //将当前TabBar的触摸点转换坐标系，转换到“添加”标签的身上，生成一个新的点
         CGPoint newL = [self convertPoint:point toView:self.addLabel];
 
         //判断如果这个新的点是在“+”按钮身上，那么处理点击事件最合适的view就是“+”按钮
         if ( [self.addButton pointInside:newA withEvent:event])
         {
             return self.addButton;
         }
         //判断如果这个新的点是在“添加”标签身上，那么也让“+”按钮处理事件
         else if([self.addLabel pointInside:newL withEvent:event])
         {
             return self.addButton;
         }
         else
         {//如果点不在“+”按钮身上，直接让系统处理就可以了
 
             return [super hitTest:point withEvent:event];
         }
     }
     else
     {
         //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
         return [super hitTest:point withEvent:event];
     }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
