//
//  UIImage+Adjustment.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Adjustment)

// 曝光
- (UIImage *)exposureWithValue:(CGFloat)value;
// 亮度 -1 -> 1 默认0
- (UIImage *)brightnessWithValue:(CGFloat)value;
// 对比度 0 -> 4 默认1
- (UIImage *)contrastWithValue:(CGFloat)value;
// 饱和度 0 -> 2 默认1
- (UIImage *)saturationWithValue:(CGFloat)value;
// 色温 0 -> 1 默认1
- (UIImage *)intensityWithValue:(CGFloat)value;
// 色调 -3.14 -> 3.14 默认0
- (UIImage *)angleWithValue:(CGFloat)value;
// 模糊 0 -> 100 默认 10
- (UIImage *)blurWithValue:(CGFloat)value;
// 阴影高亮 0.3 -> 1 默认1
- (UIImage *)highlightShadowWithValue:(CGFloat)value;

@end
