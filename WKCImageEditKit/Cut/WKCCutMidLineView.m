//
//  WKCCutMidLineView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCCutMidLineView.h"
#import "WKCCutCornerView.h"

@interface WKCCutMidLineView()

@property (nonatomic, strong) CAShapeLayer * lineLayer;

@end

@implementation WKCCutMidLineView

- (instancetype)initWithLineWidth:(CGFloat)lineWidth
                       lineHeight:(CGFloat)lineHeight
                        lineColor:(UIColor *)lineColor
{
    if (self = [super initWithFrame:CGRectMake(0, 0, MID_LINE_INTERACT_WIDTH, MID_LINE_INTERACT_HEIGHT)])
    {
        self.lineWidth = lineWidth;
        self.lineHeight = lineHeight;
        self.lineColor = lineColor;
    }
    return self;
}

- (void)setType:(WKCMidLineType)type
{
    _type = type;
    [self drawMidLine];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self drawMidLine];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    _lineLayer.strokeColor = lineColor.CGColor;
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    _lineLayer.lineWidth = lineHeight;
}


- (void)drawMidLine
{
    if(_lineLayer && _lineLayer.superlayer) {
        [_lineLayer removeFromSuperlayer];
    }
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.strokeColor = _lineColor.CGColor;
    _lineLayer.lineWidth = _lineHeight;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *midLinePath = [UIBezierPath bezierPath];
    switch (_type) {
        case WKCMidLineTypeTop:
        case WKCMidLineTypeBottom: {
            [midLinePath moveToPoint:CGPointMake((WIDTH(self) - _lineWidth) / 2.0, HEIGHT(self) / 2.0)];
            [midLinePath addLineToPoint:CGPointMake((WIDTH(self) + _lineWidth) / 2.0, HEIGHT(self) / 2.0)];
            break;
        }
        case WKCMidLineTypeRight:
        case WKCMidLineTypeLeft: {
            [midLinePath moveToPoint:CGPointMake(WIDTH(self) / 2.0, (HEIGHT(self) - _lineWidth) / 2.0)];
            [midLinePath addLineToPoint:CGPointMake(WIDTH(self) / 2.0, (HEIGHT(self) + _lineWidth) / 2.0)];
            break;
        }
        default:
            break;
    }
    _lineLayer.path = midLinePath.CGPath;
    [self.layer addSublayer: _lineLayer];
    
}

@end
