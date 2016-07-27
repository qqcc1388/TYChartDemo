//
//  LineView.m
//  DrawLine
//
//  Created by tiny on 16/7/22.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "LineView.h"

#define kMargin         0
#define kTitleCount     5
#define kXMargin        0
#define kYMargin        10

@interface LineView ()

@property (nonatomic,strong)CAShapeLayer *shapeLayer;//划线layer
@property (nonatomic,assign)CGFloat  maxYvalue;     //最大y值
@property (nonatomic,assign)CGFloat maxValueCount;  //最多显示的点数
@property (nonatomic,strong)NSMutableArray *dataArr;//数据container
@property (nonatomic,assign)int  lastValue;         //最后一组数据的值

@end

@implementation LineView

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
    
    self.dataArr = [NSMutableArray array];
    _shapeLayer = [[CAShapeLayer alloc] init];
    self.maxValueCount = 200;
    self.maxYvalue = 1024;
    
    _shapeLayer.lineWidth = 1;
    _shapeLayer.lineCap = @"round";
    _shapeLayer.lineJoin = @"round";
    _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.frame = CGRectMake(kXMargin, kYMargin, self.bounds.size.width - kXMargin, self.bounds.size.height - kYMargin*2);
//    _shapeLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.clipsToBounds = YES;
    [self.layer addSublayer:_shapeLayer];
    
    [NSTimer scheduledTimerWithTimeInterval:0.25f target:self selector:@selector(drawLine) userInfo:nil repeats:YES];
    
    [self setNeedsDisplay];
    
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.shapeLayer.strokeColor = lineColor.CGColor;
}

-(void)setRowData:(NSArray *)rowData
{
    _rowData = rowData;
    
    //rowData
//    NSMutableArray *arr = [NSMutableArray array];
//    //产生1组数据  值介于 - 100  --  100之间  100个数据  y轴值
//    for (int i = 0; i < 30; i++) {
//        NSInteger tempData = arc4random_uniform(500);
//        if (tempData%3) {
//            tempData = tempData * (-1);
//        }
//        [arr addObject:@(tempData)];
//    }
    
    [self.dataArr addObjectsFromArray:rowData];
    if (self.dataArr.count > self.maxValueCount) {
        
        //将新数据保留，旧数据从数组中删除掉
        [self.dataArr removeObjectsInRange:NSMakeRange(0, self.dataArr.count - self.maxValueCount)];
    }
    [self drawLine];
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path setLineWidth:1.0f];
//    [[UIColor redColor] set];
//    
//    [path moveToPoint:CGPointMake(kMargin,0)];
//    [path addLineToPoint:CGPointMake(kMargin, self.frame.size.height)];
//    
//    [path moveToPoint:CGPointMake(kMargin, self.frame.size.height*0.5)];
//    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.frame.size.height*0.5)];
//    [path stroke];
//    
//    //画文字
//    NSMutableArray *arr = [NSMutableArray array];
//    
//    for (int i = 0; i < kTitleCount; i++) {
//        
//        [arr  addObject:[NSString stringWithFormat:@"%.f",self.maxYvalue - self.maxYvalue/kTitleCount *i]];
//    }
//    [arr addObject:@"0"];
//    for (int i = 1; i <= kTitleCount; i++) {
//        
//        [arr  addObject:[NSString stringWithFormat:@"%.f",self.maxYvalue/kTitleCount *i]];
//    }
//    CGFloat totalHeight = CGRectGetHeight(self.bounds);
//    
//    for (int i = 0; i < arr.count ; i++) {
//        NSString *title = arr[i];
//        CGFloat y = totalHeight - (totalHeight -totalHeight/(kTitleCount*2+1)*i) + kYMargin;
//        [title drawInRect:CGRectMake(0,y, kMargin, 20) withAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:10]}];
//    }
//    
//}

-(void)drawLine
{
    self.shapeLayer.path = [[self prepareBezierPath] CGPath];
}

-(UIBezierPath *)prepareBezierPath
{
    
    CGFloat height = CGRectGetHeight(self.shapeLayer.bounds);
    CGFloat maxY = self.maxYvalue;

    //产生1组数据  总宽度/self.maxValuecount   -->  x轴值
    NSMutableArray *xArr = [NSMutableArray array];
    CGFloat xMargin = (self.frame.size.width - kMargin)/(self.maxValueCount*1.0);
    for (int i = 0; i < self.maxValueCount; i++) {
        [xArr addObject:@(xMargin*i)];
    }
    
    self.lastValue = [[self.dataArr lastObject] intValue];
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    CGPoint startPoint = CGPointMake([xArr[0] integerValue], height - height *(maxY+self.lastValue)/(maxY*2));
    [bezierPath moveToPoint:startPoint];
    
    //添加其他的线段
    for (int i = 1; i < self.dataArr.count; i++) {
        CGPoint movePoint = CGPointMake([xArr[i] intValue], height - height *(maxY+[self.dataArr[i] integerValue])/(maxY*2));
        [bezierPath addLineToPoint:movePoint];
    }
    
    return bezierPath;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _shapeLayer.frame = CGRectMake(kXMargin, kYMargin, self.bounds.size.width - kXMargin, self.bounds.size.height - kYMargin*2);
}


@end
