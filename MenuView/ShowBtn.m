//
//  ShowBtn.m
//  SelectView
//
//  Created by Yuan on 16/6/5.
//  Copyright (c) 2016年 Yuan. All rights reserved.
//

#import "ShowBtn.h"

@implementation ShowBtn



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];

    CGPoint loP = [touch locationInView:self];
    
    CGPoint prP = [touch previousLocationInView:self];
    
    CGFloat loX = loP.x;
    CGFloat loY = loP.y;
    
    CGFloat prX = prP.x;
    CGFloat prY = prP.y;
    
    
    // 获取手指在X轴移动的偏移量 = 当前手指的位置 - 上一个手指的位置
    CGFloat offsetX = loX - prX;
    
    CGFloat offsetY = loY - prY;
    
    
    // 视图的center.x +=offsetX
    CGPoint center = self.center;
    center.x += offsetX;
    center.y += offsetY;
    self.center = center;
    
    CGRect frame = self.frame;
    
    CGFloat screenW  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH  = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat w  = self.bounds.size.width;
    CGFloat h  = self.bounds.size.height;

    
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
        self.frame = frame;
    } else if (frame.origin.y < 20) {
        frame.origin.y = 20;
        self.frame = frame;
    } else if (frame.origin.x > screenW - w) {
        frame.origin.x = screenW - w;
        self.frame = frame;
    } else if (frame.origin.y > screenH - h) {
        frame.origin.y = screenH - h;
        self.frame = frame;
    }
    [super touchesMoved:touches withEvent:event];
}

@end
