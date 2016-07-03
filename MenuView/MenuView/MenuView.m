//
//  MenuView.m
//  SelectView
//
//  Created by Yuan on 16/7/3.
//  Copyright (c) 2016年 Yuan. All rights reserved.
//

#import "MenuView.h"

#define leftMargin   30     // 箭头左距离边缘距离
#define rightMargin  30     // 箭头右距离边缘距离
#define arrowHeight   10    // 箭头内部高度
#define arrowMargin   10    // 箭头内部中心间距(三角底边长度一半)


@interface MenuCoverView : UIView
{
    @public
    ArrowDirection _arrowDirection;
    UIColor *_fillColor;
}
@end

@implementation MenuView

- (void)show {
    MenuCoverView *view = [[MenuCoverView alloc] initWithFrame:CGRectMake(50, 100, 150, 250)];
    view->_arrowDirection = self.arrowDirection;
    view->_fillColor = self.fillColor;
    [self addSubview:view];
    
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
}



@end



@implementation MenuCoverView

- (void)drawRect:(CGRect)rect {
    CGFloat x = 0;
    CGFloat y = 0;
    
    if (self.arrowDirection == ArrowDirectionDefault) {
        
    } else if (self.arrowDirection == ArrowDirectionLeft) {
        x = leftMargin;
        y = arrowHeight;
    } else if (self.arrowDirection == ArrowDirectionRight) {
        x = rect.size.width - (rightMargin + 2*arrowMargin);
        y = arrowHeight;
    } else if (self.arrowDirection == ArrowDirectionMiddle) {
        x = rect.size.width/2 - arrowMargin;
        y = arrowHeight;
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(x, y);//坐标1
    sPoints[1] =CGPointMake(x + 2*arrowMargin, y);//坐标2
    sPoints[2] =CGPointMake(x + arrowMargin, y - arrowHeight);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextSetFillColorWithColor(context, _fillColor.CGColor);//填充颜色
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
}

- (void)setArrowDirection:(ArrowDirection)direction {
    _arrowDirection = direction;
    [self setNeedsDisplay];
}


- (ArrowDirection)arrowDirection {
    if (_arrowDirection) {
        return _arrowDirection;
    }
    return ArrowDirectionDefault;
}


@end