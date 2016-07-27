//
//  ViewController.m
//  ESHistogramDemo
//
//  Created by tiny on 16/7/25.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "ESHistogramView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ESHistogramView *histogramView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeInterval) userInfo:nil repeats:YES];
    
}

-(void)timeInterval
{
    self.histogramView.dataArr = @[@((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0),
                                   @((arc4random_uniform(100)+1)/100.0)
                                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
