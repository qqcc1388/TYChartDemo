//
//  TYRingView.m
//  GradientLayerDemo
//
//  Created by tiny on 16/7/25.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "TYRingView.h"

@interface TYRingView ()

@property (nonatomic,strong)CAShapeLayer *shapeLayer;

@property (nonatomic,strong)CAGradientLayer *gradientLayer;

@end

@implementation TYRingView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self  = [super initWithCoder:aDecoder]) {
        
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    
    self.lineWidth = 10.0f;
    //初始化参数
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineWidth = self.lineWidth;
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath addArcWithCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width*0.5 - self.shapeLayer.lineWidth/2.0 startAngle:-M_PI_2 endAngle: M_PI + M_PI_2  clockwise:YES];
    self.shapeLayer.path = bezierPath.CGPath;
    
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor];
    
    /*
          (0，0) -------- (1，0)
                |        |
                |   0.5  |
                |        |
          (0，1) -------- (1，1)
     */
    self.gradientLayer.startPoint = CGPointMake(0.5, 0);
    self.gradientLayer.endPoint = CGPointMake(0.5, 1);
    self.gradientLayer.mask = self.shapeLayer;
    [self.layer addSublayer:_gradientLayer];
    
}

-(void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = _lineWidth;
}

-(void)setColors:(NSArray *)colors
{
    
    _colors = colors;
    
    self.gradientLayer.colors = colors;
}


-(void)setLocations:(NSArray *)locations
{
    _locations = locations;
    self.gradientLayer.locations = locations;
}


-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = progress;
//    [CATransaction begin];
//    [CATransaction  setDisableActions:YES];
////    CAMediaTimingFunction* camtf = [[CAMediaTimingFunction alloc] init];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [CATransaction setAnimationDuration:5.0f];
//    self.shapeLayer.strokeEnd = progress;
//    
//    [CATransaction commit];
}

@end
