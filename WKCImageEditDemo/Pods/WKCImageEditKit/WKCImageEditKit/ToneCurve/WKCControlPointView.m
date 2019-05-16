//
//  WKCControlPointView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCControlPointView.h"

@implementation WKCControlPointView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rct = self.bounds;
    rct.origin.x = rct.size.width/2-rct.size.width/6;
    rct.origin.y = rct.size.height/2-rct.size.height/6;
    rct.size.width /= 3;
    rct.size.height /= 3;
    
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillEllipseInRect(context, rct);
}

- (void)setControlPoint:(CIVector *)controlPoint
{
    if(controlPoint != _controlPoint)
    {
        _controlPoint = controlPoint;
        self.center = CGPointMake(_controlPoint.X * self.layoutFrame.size.width, (1 - _controlPoint.Y) * self.layoutFrame.size.height);
    }
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    [self setNeedsDisplay];
}

@end
