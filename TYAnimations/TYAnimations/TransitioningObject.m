//
//  TransitioningObject.m
//  TYAnimations
//
//  Created by tiny on 16/8/3.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "TransitioningObject.h"
#import "AppDelegate.h"

#define kAnimationDuration    1.0f

@implementation TransitioningObject


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //拿到对应的控制器
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //可以吧containerView理解成一个舞台，参与过渡动画的角色在这个舞台上表演。。。所以要让他们上台先。
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    // 找出各个VC在tabBar上的位置。
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    NSInteger fromViewControllerIndex = [tabBarController.viewControllers indexOfObject:fromViewController];
    NSInteger toViewControllerIndex = [tabBarController.viewControllers indexOfObject:fromViewController];
    
    // 计算出点击的tab的位置，作为动画的圆心
    CGRect tabBarFrame = tabBarController.tabBar.frame;
    NSInteger tabBarItemCount = tabBarController.tabBar.items.count;
    CGFloat tabBarItemWidth = tabBarFrame.size.width /(tabBarItemCount *1.0);
    
    CGFloat tappedItemY = tabBarFrame.origin.y;
    CGFloat tappedItemX = tabBarItemWidth * toViewControllerIndex + tabBarItemWidth / 2;
    
    // 圆要放大到的半径，勾股定理算出toView的对角线长度
    CGFloat finalRadius = sqrt(pow(toView.frame.size.height, 2) + pow(toView.frame.size.width, 2));
    
    // 构造开始时和结束时的圆的贝赛尔曲线。
   
    UIBezierPath * start =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(tappedItemX, tappedItemY, 0, 0)];

    UIBezierPath * final =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(tappedItemX - finalRadius, tappedItemY - finalRadius, finalRadius*2, finalRadius*2)];
    
    // 新建一个CAShapeLayer，用作toView的遮罩。并且开始时的path设置为上面的start——位置在点击的tab上的一个半径为0的圆。
    // 下文中就要给这个path加特技，让他变化到包含整个界面那么大。
    CAShapeLayer * circleMask = [CAShapeLayer layer];
    circleMask.path = start.CGPath;
    toView.layer.mask = circleMask;
    
    // 给circleMask的path属性加动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue =(__bridge id)start.CGPath;
    animation.toValue = (__bridge id)final.CGPath;
    animation.duration = kAnimationDuration;
    animation.delegate = self; // 设置CABasicAnimation的delegate为self，好在动画结束后通知系统过渡完成了。
    [animation setValue:transitionContext forKey:@"transitionContext"];
//    animation.setValue(transitionContext, forKey: "transitionContext") // 待会需要用到transitionContext的completeTransition方法
    [circleMask addAnimation:animation forKey:@"circleAnimation"];
    circleMask.path = final.CGPath;
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    id <UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
    [transitionContext completeTransition:YES];
}
@end
