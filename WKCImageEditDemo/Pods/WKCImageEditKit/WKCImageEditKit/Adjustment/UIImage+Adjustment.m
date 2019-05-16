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
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)brightnessWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputBrightnessKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)contrastWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputContrastKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)saturationWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputSaturationKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)intensityWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputIntensityKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)angleWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputAngleKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)blurWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:kCIInputRadiusKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

- (UIImage *)highlightShadowWithValue:(CGFloat)value
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(value) forKey:@"inputHighlightAmount"];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *effetImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return effetImage;
}

@end

