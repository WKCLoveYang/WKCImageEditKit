//
//  WKCCutCornerView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCCutCornerView.h"

@interface WKCCutCornerView()

@property (nonatomic, strong) CAShapeLayer * cornerShapeLayer;

@end

@implementation WKCCutCornerView

- (instancetype)initWithFrame:(CGRect)frame
                    lineColor:(UIColor *)lineColor
                    lineWidth:(CGFloat)lineWidth
{
    if (self = [super initWithFrame:frame])
    {
        self.lineColor = lineColor;
        self.lineWidth = lineWidth;
    }
    
    return self;
}

- (void)updateSizeWithWidth:(CGFloat)width
                     height:(CGFloat)height
{
    switch (_cornerPosition)
    {
        case WKCCropAreaCornerPositionTopLeft: {
            self.frame = CGRectMake(MINX(self), MINY(self), width, height);
            break;
        }
        case WKCCropAreaCornerPositionTopRight: {
            self.frame = CGRectMake(MAXX(self) - width, MINY(self), width, height);
            break;
        }
        case WKCCropAreaCornerPositionBottomLeft: {
            self.frame = CGRectMake(MINX(self), MAXY(self) - height, width, height);
            break;
        }
        case WKCCropAreaCornerPositionBottomRight: {
            self.frame = CGRectMake(MAXX(self) - width, MAXY(self) - height, width, height);
            break;
        }
        default:
            break;
    }
    [self drawCornerLines];
}


- (void)setCornerPosition:(WKCCropAreaCornerPosition)cornerPosition
{
    _cornerPosition = cornerPosition;
    [self drawCornerLines];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self drawCornerLines];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    _cornerShapeLayer.strokeColor = lineColor.CGColor;
}

- (void)drawCornerLines
{
    if(_cornerShapeLayer && _cornerShapeLayer.superlayer) {
        [_cornerShapeLayer removeFromSuperlayer];
    }
    _cornerShapeLayer = [CAShapeLayer layer];
    _cornerShapeLayer.lineWidth = _lineWidth;
    _cornerShapeLayer.strokeColor = _lineColor.CGColor;
    _cornerShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *cornerPath = [UIBezierPath bezierPath];
    CGFloat paddingX = _lineWidth / 2.0f;
    CGFloat paddingY = _lineWidth / 2.0f;
    switch (_cornerPosition) {
        case WKCCropAreaCornerPositionTopLeft: {
            [cornerPath moveToPoint:CGPointMake(WIDTH(self), paddingY)];
            [cornerPath addLineToPoint:CGPointMake(paddingX, paddingY)];
            [cornerPath addLineToPoint:CGPointMake(paddingX, HEIGHT(self))];
            break;
        }
        case WKCCropAreaCornerPositionTopRight: {
            [cornerPath moveToPoint:CGPointMake(0, paddingY)];
            [cornerPath addLineToPoint:CGPointMake(WIDTH(self) - paddingX, paddingY)];
            [cornerPath addLineToPoint:CGPointMake(WIDTH(self) - paddingX, HEIGHT(self))];
            break;
        }
        case WKCCropAreaCornerPositionBottomLeft: {
            [cornerPath moveToPoint:CGPointMake(paddingX, 0)];
            [cornerPath addLineToPoint:CGPointMake(paddingX, HEIGHT(self) - paddingY)];
            [cornerPath addLineToPoint:CGPointMake(WIDTH(self), HEIGHT(self) - paddingY)];
            break;
        }
        case WKCCropAreaCornerPositionBottomRight: {
            [cornerPath moveToPoint:CGPointMake(WIDTH(self) - paddingX, 0)];
            [cornerPath addLineToPoint:CGPointMake(WIDTH(self) - paddingX, HEIGHT(self) - paddingY)];
            [cornerPath addLineToPoint:CGPointMake(0, HEIGHT(self) - paddingY)];
            break;
        }
        default:
            break;
    }
    _cornerShapeLayer.path = cornerPath.CGPath;
    [self.layer addSublayer: _cornerShapeLayer];
    
}

@end
