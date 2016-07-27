//
//  ESHistogramView.h
//  ESHistogramDemo
//
//  Created by tiny on 16/7/25.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESHistogramView : UIView

/**
 *  传入的数据值  0 - 1.0f
 */
@property (nonatomic,strong)NSArray *dataArr;

/**
 *  线宽
 */
@property (nonatomic,assign)CGFloat lineWidth;


@end
