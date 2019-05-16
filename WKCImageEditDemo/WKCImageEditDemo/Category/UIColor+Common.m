//
//  UIColor+Extension.m
//  ffff
//
//  Created by 魏昆超 on 2019/1/9.
//  Copyright © 2019 魏昆超. All rights reserved.
//

#import "UIColor+Common.h"

@implementation UIColor (Common)

- (CGFloat)mRed
{
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return red;
}

- (CGFloat)mGreen
{
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return green;
}

- (CGFloat)mBlue
{
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return blue;
}

- (CGFloat)mAlpha
{
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return alpha;
}

+ (UIColor *)colorWithHexInt:(NSInteger)hexInt
{
    NSString * hexString = [NSString stringWithFormat:@"%06lx",(long)hexInt];
    return [self colorWithHexStr:hexString];
}

+ (UIColor *)colorWithHexStr:(NSString *)hexStr
{
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:charSet] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (UIImage *)toImage
{
    return [self toImageWithSize:CGSizeMake(1, 1)];
}

- (UIImage *)toImageWithSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    [self setFill];
    UIRectFill(rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)gradientWithColors:(NSArray<NSNumber *> *)hexs
{
    return [self gradientWithSize:CGSizeMake(10000, 10000)
                           colors:hexs];
}

+ (UIColor *)gradientWithSize:(CGSize)size
                       colors:(NSArray<NSNumber *> *)hexs
{
    return [self gradientWithSize:size
                            start:CGPointZero
                              end:CGPointMake(1, 1)
                        locations:@[@(0.5)]
                           colors:hexs];
}

+ (UIColor *)gradientWithSize:(CGSize)size
                        style:(GradientStyle)style
                     locations:(NSArray <NSNumber *>*)loc
                        colors:(NSArray<NSNumber *> *)hexs
{
    CGPoint start = CGPointZero, end = CGPointZero;
    switch (style) {
        case GradientStyleBottomToTop:
        {
            start = CGPointMake(0, 1);
        }
            break;
        case GradientStyleLeftToRight:
        {
            end = CGPointMake(1, 0);
        }
            break;
        case GradientStyleRightToLeft:
        {
            start = CGPointMake(1, 0);
        }
            break;
        case GradientStyleTopToBottom:
        {
            end = CGPointMake(0, 1);
        }
            break;
        case GradientStyleLeftBottomToRightTop:
        {
            start = CGPointMake(0, 1);
            end = CGPointMake(1, 0);
        }
            break;
        case GradientStyleLeftTopToRightBottom:
        {
            end = CGPointMake(1, 1);
        }
            break;
        case GradientStyleRightBottomToLeftTop:
        {
            start = CGPointMake(1, 1);
        }
            break;
        case GradientStyleRightTopToLeftBottom:
        {
            start = CGPointMake(1, 0);
            end = CGPointMake(0, 1);
        }
            break;
    }
    
    UIImage * image = [self imageWithGradientColors:hexs
                                         startPoint:start
                                           endPoint:end
                                            corners:UIRectCornerAllCorners
                                       cornerRadius:0
                                        borderWidth:0
                                        borderColor:UIColor.clearColor
                                               size:size];
    return [UIColor colorWithPatternImage:image];
    
}

+ (UIColor *)gradientWithSize:(CGSize)size
                        start:(CGPoint)start
                          end:(CGPoint)end
                    locations:(NSArray <NSNumber *>*)loc
                       colors:(NSArray<NSNumber *> *)hexs
{
    UIImage * image = [self imageWithGradientColors:hexs
                                         startPoint:start
                                           endPoint:end
                                            corners:UIRectCornerAllCorners
                                       cornerRadius:0
                                        borderWidth:0
                                        borderColor:UIColor.clearColor
                                               size:size];
    return [UIColor colorWithPatternImage:image];
}

+ (UIImage *)imageWithGradientColors:(NSArray<NSNumber *> *)rgbaHexAr
                             startPoint:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint
                                corners:(UIRectCorner)corners
                           cornerRadius:(CGFloat)radius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                                   size:(CGSize)size
{
    CGRect boundingRect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(boundingRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (borderWidth > 0) {
        CGFloat bof = borderWidth/2.f;
        boundingRect = CGRectInset(boundingRect, bof, bof);
    }
    
    UIBezierPath *cornerspath = [UIBezierPath bezierPathWithRoundedRect:boundingRect
                                                      byRoundingCorners:corners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    CGPathRef path = [cornerspath CGPath];
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    if (rgbaHexAr.count == 1) {
        rgbaHexAr = [rgbaHexAr arrayByAddingObject:rgbaHexAr[0]];
    }
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[rgbaHexAr.count * 4];
    for (NSInteger idx = 0; idx < rgbaHexAr.count; idx++) {
        NSNumber *rgbaNumber = rgbaHexAr[idx];
        NSUInteger rgba = [rgbaNumber unsignedIntegerValue];
        for (int i = 0; i < 4; i++) {
            CGFloat value = (rgba >> (24 - 8*i)) & 0xFF;
            colors[idx * 4 + i] = value / 255.f;
        }
    }
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    CGPoint sp = CGPointMake(boundingRect.size.width * startPoint.x, boundingRect.size.height * startPoint.y);
    CGPoint ep = CGPointMake(boundingRect.size.width * endPoint.x, boundingRect.size.height * endPoint.y);
    
    CGContextDrawLinearGradient(context, gradient, sp, ep, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    
    if (borderWidth > 0 && borderColor) {
        CGContextResetClip(context);
        CGContextAddPath(context, path);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderWidth);
        CGContextStrokePath(context);
    }
    
    UIImage* const image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeStretch];
}

@end
