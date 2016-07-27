//
//  OctopusView.m
//  OctopusFigureDemo
//
//  Created by tiny on 16/7/26.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "OctopusView.h"

#define kMargin   30
#define kGapping  5
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
@interface OctopusView ()

@property (nonatomic,strong)CAShapeLayer *shapeLayer;
@property (nonatomic,assign)CGFloat radius;
@property (nonatomic,strong)UIBezierPath *myPath;


@end

@implementation OctopusView


+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
    }
    return self;
}

-(void)initialize
{
     CAReplicatorLayer *layer = (id)[self layer];
    
    self.shapeLayer = [CAShapeLayer layer];
//    self.shapeLayer.frame = CGRectMake(kMargin, kMargin, self.bounds.size.width- kMargin*2, self.bounds.size.height - kMargin*2);
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    self.shapeLayer.lineWidth = 1.0f;
//    self.shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    self.shapeLayer.lineJoin = kCALineJoinRound;
    
    [layer addSublayer:self.shapeLayer];
    layer.instanceCount = 10;
    layer.instanceDelay = (0.4f - 0.01)/10.0;
    layer.instanceAlphaOffset = -0.95f/10.0;
     layer.instanceBlueOffset = -0.5f/10.0;
//    [self.layer addSublayer:self.shapeLayer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(drawFigure) userInfo:nil repeats:YES];
}


-(void)drawFigure
{
    //设置bezierPath  0度开始顺时针旋转
    UIBezierPath *path = [UIBezierPath bezierPath];
//    NSArray *arr = @[@(0.5f),@(1.0f),@(0.5f),@(1.0f),@(0.5f),@(1.0f),@(0.5f),@(1.0f)];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0 ; i < 8; i++) {
        [arr addObject:@((arc4random_uniform(50)+50)/100.0)];
    }

    CGPoint point0  = CGPointMake(self.radius+self.radius*[arr[0] floatValue], self.radius);
    
    CGPoint point1  = CGPointMake(self.radius+self.radius*[arr[1] floatValue]*cos(M_PI_4), self.radius + self.radius*[arr[1] floatValue]*cos(M_PI_4));

    CGPoint point2  = CGPointMake(self.radius, self.radius+self.radius*[arr[2] floatValue]);

    CGPoint point3  = CGPointMake(self.radius-self.radius*[arr[3] floatValue]*cos(M_PI_4), self.radius + self.radius*[arr[3] floatValue]*cos(M_PI_4));

    CGPoint point4  = CGPointMake(self.radius - self.radius*[arr[4] floatValue], self.radius);

    CGPoint point5  = CGPointMake(self.radius - self.radius*[arr[5] floatValue]*cos(M_PI_4), self.radius - self.radius*[arr[5] floatValue]*cos(M_PI_4));

    CGPoint point6  = CGPointMake(self.radius, self.radius - self.radius*[arr[6] floatValue]);
    
    CGPoint point7  = CGPointMake(self.radius+self.radius*[arr[7] floatValue]*cos(M_PI_4), self.radius - self.radius*[arr[7] floatValue]*cos(M_PI_4));
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path addLineToPoint:point0];
    self.myPath = path;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.delegate = self;
    pathAnimation.duration = (0.4f - 0.01);
    pathAnimation.fromValue = (__bridge id)(self.shapeLayer.path);
    pathAnimation.toValue = (__bridge id)(path.CGPath);
    pathAnimation.timingFunction = [CAMediaTimingFunction
                                functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.shapeLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
    self.shapeLayer.path = path.CGPath;


}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
   
    self.shapeLayer.path = self.myPath.CGPath;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //画背景
    CGFloat radius = (self.bounds.size.width*0.5 - kMargin)/5.0;
    self.radius = self.radius*5;
    for (int i = 0; i < 5; i++) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:i*radius+radius startAngle:-M_PI_2 endAngle:M_PI*2+M_PI_2 clockwise:YES];
        [bezierPath setLineWidth:1.0f];
        [UIColor colorWithRed:2/255.0 green:122/255.0 blue:166/255.0 alpha:1.0f];
        [bezierPath stroke];
    }
    //水平
    UIBezierPath *horizonPath = [UIBezierPath bezierPath];
    [horizonPath moveToPoint:CGPointMake(kMargin, self.bounds.size.height*0.5)];
    [horizonPath addLineToPoint:CGPointMake(self.bounds.size.width - kMargin, self.bounds.size.height*0.5)];
    [horizonPath setLineWidth:1.0f];
    [horizonPath stroke];
    
    
    //垂直
     UIBezierPath *verticaPath = [horizonPath copy];
    [verticaPath moveToPoint:CGPointMake(self.bounds.size.width*0.5, kMargin)];
    [verticaPath addLineToPoint:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height - kMargin)];
//    [verticaPath applyTransform:CGAffineTransformMakeTranslation(50,50)];
//    [verticaPath applyTransform:CGAffineTransformMakeRotation(RADIANS_TO_DEGREES(45))];
    [verticaPath stroke];
    
    CGFloat radiusMax  = self.radius;
    CGFloat a = sqrt(radiusMax*radiusMax*0.5);
    UIBezierPath *leftPath = [horizonPath copy];
    [leftPath moveToPoint:CGPointMake(self.bounds.size.width*0.5 - a, self.bounds.size.height*0.5 - a)];
    [leftPath addLineToPoint:CGPointMake(self.bounds.size.width*0.5 + a, self.bounds.size.height *0.5 + a)];
    [leftPath stroke];
    
    UIBezierPath *rightPath = [horizonPath copy];
    [rightPath moveToPoint:CGPointMake(self.bounds.size.width*0.5 - a, self.bounds.size.height*0.5 + a)];
    [rightPath addLineToPoint:CGPointMake(self.bounds.size.width*0.5 + a , self.bounds.size.height*0.5 - a)];
    [rightPath stroke];
    
    //画文字   从0度开始 顺时针画文字
    NSArray *titleArr = @[@"δ",@"θ",@"低α",@"高α",@"低β",@"高β",@"低γ",@"高γ"];

    [self drawTitleWithString:titleArr[0] Frame:CGRectMake(self.bounds.size.width *0.5 + self.radius+kGapping, self.bounds.size.height*0.5 - 10, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[1] Frame:CGRectMake(self.bounds.size.width*0.5+a+kGapping, self.bounds.size.height*0.5+a, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[2] Frame:CGRectMake(self.bounds.size.width*0.5 - 13, self.bounds.size.height*0.5+self.radius+kGapping, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[3] Frame:CGRectMake(self.bounds.size.width*0.5 - a - 20, self.bounds.size.height*0.5 + a, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[4] Frame:CGRectMake(kGapping, self.bounds.size.height*0.5 - 10, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[5] Frame:CGRectMake(self.bounds.size.width*0.5 - a - 20, self.bounds.size.height*0.5 - a - 20, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[6] Frame:CGRectMake(self.bounds.size.width*0.5 - 10,kGapping+2, kMargin - kGapping, 20)];
    [self drawTitleWithString:titleArr[7] Frame:CGRectMake(self.bounds.size.width*0.5 + a + 5, self.bounds.size.height*0.5 - a  - 15, kMargin - kGapping, 20)];
}

-(void)drawTitleWithString:(NSString *)title Frame:(CGRect)frame
{
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:14],
                           NSForegroundColorAttributeName:[UIColor whiteColor]
                           };
    [title drawInRect:frame withAttributes:dict];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.radius = (self.bounds.size.width*0.5 - kMargin)/5.0;

    self.shapeLayer.frame = CGRectMake(kMargin, kMargin, self.bounds.size.width- kMargin*2, self.bounds.size.height - kMargin*2);
    
    [self setNeedsDisplay];
}

@end
