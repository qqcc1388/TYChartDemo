//
//  ESHistogramView.m
//  ESHistogramDemo
//
//  Created by tiny on 16/7/25.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ESHistogramView.h"


@interface UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

@implementation UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end


#define kMargin self.bounds.size.height/11.0   //画10根线

@interface ESHistogramView ()

@property (nonatomic,strong)NSMutableArray *shapeLayerArr;
@property (nonatomic,assign)CGFloat viewHeight;
@property (nonatomic,assign)CGFloat viewWidth;



@end

@implementation ESHistogramView

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
    self.backgroundColor = [UIColor colorWithRed:21/255.0 green:62/255.0 blue:114/255.0 alpha:1.0f];
    self.viewWidth = self.bounds.size.width;
    self.viewHeight = self.bounds.size.height;
    self.shapeLayerArr = [NSMutableArray array];
    int  cloune = 8;
    self.lineWidth = 30;
    NSArray *colors = @[[UIColor colorWithHexString:@"0xe7515d"],
                        [UIColor colorWithHexString:@"0xec74a1"],
                        [UIColor colorWithHexString:@"0x3d82ea"],
                        [UIColor colorWithHexString:@"0x0b9cef"],
                        [UIColor colorWithHexString:@"0xf4c33a"],
                        [UIColor colorWithHexString:@"0x00ff72"],
                        [UIColor colorWithHexString:@"0xfc8a4b"],
                        [UIColor colorWithHexString:@"0xd74df5"]
                        ];
    
    for (int i = 0; i < cloune; i++) {
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.lineWidth = self.lineWidth;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [(UIColor *)colors[i] CGColor];
        [self.shapeLayerArr addObject:shapeLayer];
        [self.layer addSublayer:shapeLayer];
    }
    
    [self histogramStartAnimation];
}

-(void)reloadShapeLayerFrame
{
    int  cloune = 8;
    //创建柱状图片
    CGFloat margin = 5;
    CGFloat lineWidth = self.lineWidth;
    CGFloat startX = margin;
    CGFloat y = self.viewHeight - kMargin;
    CGFloat gap = (self.viewWidth - margin*2 - cloune*lineWidth)/((cloune - 1)*1.0);
    
    for (int i = 0; i < self.shapeLayerArr.count; i++) {
        CAShapeLayer *shapeLayer = self.shapeLayerArr[i];
        shapeLayer.frame = CGRectMake(startX+(gap+lineWidth)*i,kMargin, lineWidth,self.viewHeight - kMargin*2);
        UIBezierPath *bezerPath = [[UIBezierPath alloc] init];
        [bezerPath moveToPoint:CGPointMake(lineWidth*0.5,y - kMargin)];
        [bezerPath addLineToPoint:CGPointMake(lineWidth*0.5,0)];
        shapeLayer.path = bezerPath.CGPath;
        shapeLayer.strokeStart = 0;
    }
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    //根据内容设置高度
    [self histogramStartAnimation];
}

-(void)histogramStartAnimation
{
    for (int i = 0; i < self.shapeLayerArr.count; i++) {
        CAShapeLayer *shapeLayer = self.shapeLayerArr[i];
        if (shapeLayer) {
            shapeLayer.strokeStart = 0;
            CGFloat progress = [self.dataArr[i] floatValue];
            if (progress > 1.0f) {
                progress = 1.0f;
            }
            if(progress == 0)
            {
                progress = 0.01;
            }
            shapeLayer.strokeEnd = progress;
        }
    }
}


-(void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsLayout];
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //划线
    for (int i = 1; i <= 10; i++) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [[UIColor colorWithHexString:@"0x027aa6"] set];
        [path setLineWidth:1.0f];
        [path moveToPoint:CGPointMake(0, kMargin*i)];
        [path addLineToPoint:CGPointMake(self.viewWidth, kMargin*i)];
        [path stroke];
    }
    //数字
    NSArray *dataArr = @[@"0HZ",@"10",@"20",@"30",@"40",@"50"];
    
    CGFloat margin = self.viewWidth/(dataArr.count -1) - 5;
    CGFloat y = self.viewHeight - 20;
    CGFloat x = 0;
    //画数字
    NSMutableParagraphStyle * style = [NSMutableParagraphStyle new];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                           NSForegroundColorAttributeName:[UIColor whiteColor],
                           NSParagraphStyleAttributeName : style
                           };
    
    for (int i = 0; i <dataArr.count; i++) {
        NSString *numStr = dataArr[i];
        if (i == 0) {
            x = 0;
        }
        else
        {
            x = margin*i;
        }
        [numStr drawInRect:CGRectMake(x, y, 30, 15) withAttributes:dict];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.viewHeight = self.bounds.size.height;
    self.viewWidth = self.bounds.size.width;
    [self reloadShapeLayerFrame];
}

@end
