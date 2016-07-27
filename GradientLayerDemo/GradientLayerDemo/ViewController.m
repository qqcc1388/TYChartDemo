//
//  ViewController.m
//  GradientLayerDemo
//
//  Created by tiny on 16/7/25.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "TYRingView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TYRingView *RingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.RingView.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor greenColor].CGColor];
//    self.RingView.locations = @[@(0.2f),@(0.65),@(0.9)];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeInterval) userInfo:nil repeats:YES];
}

-(void)timeInterval
{
    self.RingView.progress = arc4random_uniform(100)/100.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
