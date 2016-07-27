//
//  ViewController.m
//  DrawLine
//
//  Created by tiny on 16/7/22.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet LineView *containView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(timeInterval) userInfo:nil repeats:YES];
    
    self.containView.lineColor = [UIColor colorWithRed:0 green:252/255.0 blue:255/255.0 alpha:1.0f];
    
}



-(void)timeInterval
{
    //rowData
        NSMutableArray *arr = [NSMutableArray array];
        //产生1组数据  值介于 - 100  --  100之间  100个数据  y轴值
        for (int i = 0; i < 30; i++) {
            NSInteger tempData = arc4random_uniform(500);
            if (tempData%3) {
                tempData = tempData * (-1);
            }
            [arr addObject:@(tempData)];
        }
    self.containView.rowData = arr;
}

@end
