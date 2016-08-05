//
//  TYTabbarController.m
//  TYAnimations
//
//  Created by tiny on 16/8/3.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "TYTabbarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "TransitioningObject.h"

@interface TYTabbarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) TransitioningObject*transitionobject;

@end

@implementation TYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"first" image:nil selectedImage:nil];
    
    self.delegate = self;
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"second" image:nil selectedImage:nil];
    
    self.viewControllers = @[firstVC,secondVC];
}

-(TransitioningObject *)transitionobject
{
    if (_transitionobject == nil) {
        
        _transitionobject = [[TransitioningObject alloc] init];
    }
    return _transitionobject;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    return self.transitionobject;
}


@end
