//
//  ViewController.m
//  ESOriginalWaveform
//
//  Created by tiny on 16/7/26.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "ESHistogramView.h"
#import "LineView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ESHistogramView *histogramView;
@property (weak, nonatomic) IBOutlet LineView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timeInterval) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeInterval2) userInfo:nil repeats:YES];
    
    self.lineView.lineColor = [UIColor colorWithRed:0 green:252/255.0 blue:255/255.0 alpha:1.0f];
    
    [self.histogramView bringSubviewToFront:_lineView];
}


-(void)timeInterval2
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

-(void)timeInterval
{
    //rowData
    NSMutableArray *arr = [NSMutableArray array];
    //产生1组数据  值介于 - 100  --  100之间  100个数据  y轴值
    for (int i = 0; i < 30; i++) {
        NSInteger tempData = arc4random_uniform(100);
        if (tempData%3) {
            tempData = tempData * (-1);
        }
        [arr addObject:@(tempData)];
    }
    self.lineView.rowData = arr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
