//
//  UIImage+Filter.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UIImage+Filter.h"

@implementation UIImage (Filter)

- (UIImage *)filterWithType:(UIImageFilterType)type
{
    NSArray <NSString *>* filters = @[@"CILinearToSRGBToneCurve",@"CIPhotoEffectChrome",@"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer"];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:filters[type] keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    CIImage *outputImage = [filter outputImage];
    UIImage *effetImage = [UIImage imageWithCIImage:outputImage];
    return effetImage;
}


@end
