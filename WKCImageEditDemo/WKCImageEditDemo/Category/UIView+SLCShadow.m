//
//  UIView+SLCShadow.m
//  AlmightyTest1
//
//  Created by 魏昆超 on 2018/9/14.
//  Copyright © 2018年 SecretLisa. All rights reserved.
//

#import "UIView+SLCShadow.h"

struct SLCShadow _shadow;
struct SLCCorner _corner;

@implementation UIView (SLCShadow)

- (void)setShadow:(struct SLCShadow)shadow
{
    _shadow = shadow;
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = shadow.cornerRadius;
    self.layer.shadowColor = [UIView colorWithHex:shadow.colorHex].CGColor;
    self.layer.shadowOffset = shadow.offset;
    self.layer.shadowOpacity = shadow.opacity;
    self.layer.shadowRadius = shadow.blur / 2;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (struct SLCShadow)shadow
{
    return _shadow;
}

- (void)setCorner:(struct SLCCorner)corner
{
    _corner = corner;
    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, corner.size.width, corner.size.height) byRoundingCorners:corner.corners cornerRadii:CGSizeMake(corner.cornerRadius , corner.cornerRadius)];
    CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
    fieldLayer.frame = CGRectMake(0, 0, corner.size.width, corner.size.height);
    fieldLayer.path = fieldPath.CGPath;
    self.layer.mask = fieldLayer;
}

- (struct SLCCorner)corner
{
    return _corner;
}

+ (UIColor *)colorWithHex:(NSInteger)rgbHexValue
{
    return [UIView colorWithHex:rgbHexValue alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)rgbHexValue
                        alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbHexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbHexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
