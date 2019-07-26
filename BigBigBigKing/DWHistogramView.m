//
//  DWHistogramView.m
//  BigBigBigKing
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 QIaobuyong. All rights reserved.
//

#import "DWHistogramView.h"

@interface DWHistogramView ()
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation DWHistogramView

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.titleArray = @[@"标题11",@"标题22",@"标题33",@"标题44",@"标题55",@"标题66",@"标题77",@"标题88"];
//        self.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//}

- (instancetype)initWithModelArray:(NSArray *)modelArray{
    self = [self init];
    if (self) {
        self.titleArray = [NSArray arrayWithArray:modelArray];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    NSInteger dottedLineCount = 3; //虚横线数量
//    NSInteger intervalHeight  = 80;//间隔高度
 
    CGFloat HorizontallineX = 0.1*width; //左下角起始点x值
    CGFloat HorizontallineY = 0.8*height;// 起始点Y值
    CGFloat HorizontallineWidth = 0.8*width;//横轴线宽

    NSInteger levelScale = 10; //水平间距
    NSInteger ScaleCount =  HorizontallineWidth/2; //刻度数量
    NSInteger ColumnWidth = 8; //柱宽度
    NSInteger bottomViewHight = 40; //bootomView高度
    
    
    NSArray *NArray = @[@1,@2,@3,@4,@5,@2,@3,@2];    //N倍的刻度值,控制两个柱距离
    NSArray *HArray = @[@10,@20,@200,@300,@150,@120,@130,@210];  //柱高度
    
    __block NSInteger LastDistance = HorizontallineX; //上一个距离X值
    CGFloat duration = 2.0f;
    
    [self.titleArray enumerateObjectsUsingBlock:^(NSString *xTittle, NSUInteger idx, BOOL * _Nonnull stop) {

        NSInteger ScaleDistance = [NArray[idx] integerValue]; //几倍柱间距
        NSInteger ColumnHeight = [HArray[idx] integerValue]; //柱高度

        //绘制垂直line
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(LastDistance + ScaleDistance*levelScale, HorizontallineY)];
        [linePath addLineToPoint:CGPointMake(LastDistance + ScaleDistance*levelScale, HorizontallineY-ColumnHeight)];
        LastDistance = LastDistance + ScaleDistance*levelScale;

        CAShapeLayer *shaperLayer = [CAShapeLayer layer];
        shaperLayer.path = linePath.CGPath;
        shaperLayer.frame = self.bounds;
        shaperLayer.lineWidth = ColumnWidth;
        shaperLayer.lineCap = kCALineCapRound;
        shaperLayer.fillColor =  [UIColor clearColor].CGColor;
        shaperLayer.strokeColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:shaperLayer];

        //渐变色
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = shaperLayer.frame;
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:174.0f/255.0f green:156.0f/255.0f blue:251.0f/255.0f alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:91.0f/255.0f green:158.0f/255.0f blue:251.0f/255.0f alpha:1].CGColor];

        [gradientLayer setLocations:@[@0.2,@0.9]];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);

        [gradientLayer setMask:shaperLayer];
        [self.layer  addSublayer:gradientLayer];

        //增加动画
        CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = duration;
        pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses=NO;
        [shaperLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

    }];

    
 
    //横画轴线
    
//    UIBezierPath *Horizontalline = [UIBezierPath bezierPath];
//    [Horizontalline moveToPoint:CGPointMake(HorizontallineX , HorizontallineY)];
//    [Horizontalline addLineToPoint:CGPointMake(HorizontallineX + HorizontallineWidth, HorizontallineY)];
//    Horizontalline.lineWidth = 1;
//    [Horizontalline stroke];
    
    
    //    虚线
    for (int i = 1 ; i <= dottedLineCount; i ++) {
        UILabel *rightLabel =[[UILabel alloc]init]; //右侧展示文字
        rightLabel.frame = CGRectMake(HorizontallineX+HorizontallineWidth, HorizontallineY-self.intervalHeight*i-10, 50, 20);
        rightLabel.text = [NSString stringWithFormat:@"%.fK",0.5*i];
        [self addSubview:rightLabel];
        
        CGContextRef context =UIGraphicsGetCurrentContext();
        // 设置线条的样式
        CGContextSetLineCap(context, kCGLineCapRound);
        // 绘制线的宽度
        CGContextSetLineWidth(context, 2);
        // 线的颜色
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        // 开始绘制
        CGContextBeginPath(context);
        // 设置虚线绘制起点
        CGContextMoveToPoint(context, HorizontallineX,HorizontallineY-self.intervalHeight *i);
        // lengths 表示1 跳空格5 再一个点
        CGFloat lengths[] = {1,5};
        // 虚线的起始点
        CGContextSetLineDash(context, 0, lengths,2);
        // 绘制虚线的终点
        CGContextAddLineToPoint(context, HorizontallineX+HorizontallineWidth,HorizontallineY-self.intervalHeight*i);
        // 绘制
        CGContextStrokePath(context);
        // 关闭图像
        CGContextClosePath(context);
        
    }

    
    //这个view 添加title父视图
    UIView *bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(HorizontallineX, HorizontallineY, HorizontallineWidth, bottomViewHight);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    //横轴,和用于覆盖shaperLayer.lineCap = kCALineCapRound 下底半圆
    UIView *bottomViewline = [[UIView alloc]init];
    bottomViewline.frame = CGRectMake(0, 0, HorizontallineWidth, 1);
    bottomViewline.backgroundColor = [UIColor grayColor];
    [bottomView addSubview:bottomViewline];
    
    
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

@end
