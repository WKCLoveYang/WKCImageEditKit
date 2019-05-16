//
//  UIImage+Flip.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Flip)

/**
 修正图片方向
 
 @return 返回修正后的图片
 */
- (UIImage *)fixOrientation;

/**
 垂直翻转
 
 @return 返回翻转后的图片
 */
- (UIImage *)flipVertical;

/**
 水平翻转
 
 @return 返回翻转后的图片
 */
- (UIImage *)flipHorizontal;

/**
 按角度旋转图片
 
 @param degrees 角度
 @return 返回旋转后的图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 按弧度旋转图片
 
 @param radians 弧度
 @return 返回旋转后的图片
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

@end
