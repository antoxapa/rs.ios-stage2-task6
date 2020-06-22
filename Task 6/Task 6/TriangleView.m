//
//  TriangleView.m
//  Task 6
//
//  Created by Антон Потапчик on 6/19/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "TriangleView.h"
#import "UIColor+HexString.h"

@implementation TriangleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, (CGRectGetMaxX(rect)/2.0), CGRectGetMinY(rect));
    CGContextClosePath(context);
     
    [[UIColor appGreenColor]setFill];
    [[UIColor appGreenColor]setStroke];
    CGContextFillPath(context);
}


@end
