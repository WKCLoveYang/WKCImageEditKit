//
//  UIImage+Blend.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/17.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UIImage+Blend.h"

@implementation UIImage (Blend)

- (UIImage *)imageWithFront:(UIImage *)front
                      alpha:(CGFloat)alpha
                  blendMode:(WKCBlendMode)mode
{
    CGBlendMode blend;
    switch (mode)
    {
        case WKCBlendModeMiddle:
            blend = kCGBlendModeHardLight;
            break;
            
        case WKCBlendModeMiddleSoft:
            blend = kCGBlendModePlusLighter;
            break;
            
        case WKCBlendModeMiddleColor:
            blend = kCGBlendModeColorDodge;
            break;
            
        case WKCBlendModeMiddleSoftLight:
            blend = kCGBlendModeScreen;
            break;
            
        case WKCBlendModeMiddleAroundDark:
            blend = kCGBlendModeExclusion;
            break;
            
        case WKCBlendModeMiddleAroundPulsDark:
            blend = kCGBlendModeLighten;
            break;
            
        case WKCBlendModeFront:
            blend = kCGBlendModeDifference;
            break;
            
        case WKCBlendModeFrontGray:
            blend = kCGBlendModeLuminosity;
            break;
            
        case WKCBlendModeFrontHard:
            blend = kCGBlendModeSourceAtop;
            break;
            
        case WKCBlendModeFrontLight:
            blend = kCGBlendModeOverlay;
            break;
            
        case WKCBlendModeFrontSoftLight:
            blend = kCGBlendModeSoftLight;
            break;
            
        case WKCBlendModeBackground:
            blend = kCGBlendModeSoftLight;
            break;
            
        case WKCBlendModeBackgroundDark:
            blend = kCGBlendModeMultiply;
            break;
            
        case WKCBlendModeBackgroundLight:
            blend = kCGBlendModeDarken;
            break;
            
        default:
            blend = kCGBlendModeHardLight;
            break;
    }
    
    front = [front imageScalingToSize:self.size];
    UIGraphicsBeginImageContext(self.size);
    CGRect rect = CGRectMake(0,0,self.size.width,self.size.height);
    [self drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    [front drawInRect:rect blendMode:blend alpha:alpha];
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

@end
