//
//  TYRingView.h
//  GradientLayerDemo
//
//  Created by tiny on 16/7/25.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYRingView : UIView

@property (nonatomic,assign)CGFloat progress;

@property (nonatomic,strong)NSArray *colors;

@property (nonatomic,strong)NSArray *locations;

@property (nonatomic,assign)CGFloat lineWidth;


@end
