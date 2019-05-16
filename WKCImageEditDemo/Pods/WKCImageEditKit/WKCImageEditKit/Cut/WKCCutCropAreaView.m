//
//  WKCCutCropAreaView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCCutCropAreaView.h"
#import "WKCCutCornerView.h"

@interface WKCCutCropAreaView()

@property (nonatomic, strong) CAShapeLayer * crossLineLayer;
@property (nonatomic, strong) CAShapeLayer * borderLayer;

@end

@implementation WKCCutCropAreaView

- (instancetype)init
{
    if(self = [super init])
    {
        [self createBorderLayer];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if(_showCrossLines)
    {
        [self showCrossLineLayer];
    }
    [self resetBorderLayerPath];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    if(_showCrossLines)
    {
        [self showCrossLineLayer];
    }
    [self resetBorderLayerPath];
}


- (void)setCrossLineWidth:(CGFloat)crossLineWidth
{
    _crossLineWidth = crossLineWidth;
    _crossLineLayer.lineWidth = crossLineWidth;
}

- (void)setCrossLineColor:(UIColor *)crossLineColor
{
    _crossLineColor = crossLineColor;
    _crossLineLayer.strokeColor = crossLineColor.CGColor;
}

- (void)setShowCrossLines:(BOOL)showCrossLines
{
    if(_showCrossLines && !showCrossLines)
    {
        [_crossLineLayer removeFromSuperlayer];
        _crossLineLayer = nil;
    }
    else if(!_showCrossLines && showCrossLines)
    {
        [self showCrossLineLayer];
    }
    _showCrossLines = showCrossLines;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    [self resetBorderLayerPath];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _borderLayer.strokeColor = borderColor.CGColor;
}


- (void)showCrossLineLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(WIDTH(self) / 3.0, 0)];
    [path addLineToPoint: CGPointMake(WIDTH(self) / 3.0, HEIGHT(self))];
    [path moveToPoint:CGPointMake(WIDTH(self) / 3.0 * 2.0, 0)];
    [path addLineToPoint: CGPointMake(WIDTH(self) / 3.0 * 2.0, HEIGHT(self))];
    [path moveToPoint:CGPointMake(0, HEIGHT(self) / 3.0)];
    [path addLineToPoint: CGPointMake(WIDTH(self), HEIGHT(self) / 3.0)];
    [path moveToPoint:CGPointMake(0, HEIGHT(self) / 3.0 * 2.0)];
    [path addLineToPoint: CGPointMake(WIDTH(self), HEIGHT(self) / 3.0 * 2.0)];
    if(!_crossLineLayer) {
        _crossLineLayer = [CAShapeLayer layer];
        [self.layer addSublayer: _crossLineLayer];
    }
    _crossLineLayer.lineWidth = _crossLineWidth;
    _crossLineLayer.strokeColor = _crossLineColor.CGColor;
    _crossLineLayer.path = path.CGPath;
}

- (void)createBorderLayer
{
    if(_borderLayer && _borderLayer.superlayer) {
        [_borderLayer removeFromSuperlayer];
    }
    _borderLayer = [CAShapeLayer layer];
    [self.layer addSublayer: _borderLayer];
}

- (void)resetBorderLayerPath
{
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithRect: CGRectMake(_borderWidth / 2.0f, _borderWidth / 2.0f, WIDTH(self) - _borderWidth, HEIGHT(self) - _borderWidth)];
    _borderLayer.lineWidth = _borderWidth;
    _borderLayer.fillColor = nil;
    _borderLayer.path = layerPath.CGPath;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for(UIView *subView in self.subviews) {
        if(CGRectContainsPoint(subView.frame, point)) {
            return subView;
        }
    }
    if(CGRectContainsPoint(self.bounds, point)) {
        return self;
    }
    return nil;
}

@end
