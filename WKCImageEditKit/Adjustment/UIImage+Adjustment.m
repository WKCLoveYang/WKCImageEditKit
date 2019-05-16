//
//  UIImage+Adjustment.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UIImage+Adjustment.h"

@implementation UIImage (Adjustment)

- (UIImage *)exposureWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:@"inputEV"];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)brightnessWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputBrightnessKey];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)contrastWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputContrastKey];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)saturationWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputSaturationKey];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)intensityWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputIntensityKey];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)angleWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputAngleKey];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)blurWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputRadiusKey];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

- (UIImage *)highlightShadowWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:@"inputHighlightAmount"];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}

@end
