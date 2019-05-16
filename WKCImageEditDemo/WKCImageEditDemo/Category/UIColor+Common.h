//
//  UIColor+Extension.h
//  ffff
//
//  Created by 魏昆超 on 2019/1/9.
//  Copyright © 2019 魏昆超. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 渐变色样式

 - GradientStyleLeftToRight: 从左到右
 - GradientStyleRightToLeft: 从右到左
 - GradientStyleTopToBottom: 从上到下
 - GradientStyleBottomToTop: 从下到上
 - GradientStyleLeftTopToRightBottom: 左上角到右下角
 - GradientStyleRightTopToLeftBottom: 右上角到左下角
 - GradientStyleRightBottomToLeftTop: 右下角到左上角
 - GradientStyleLeftBottomToRightTop: 左下角到右上角
 */
typedef NS_ENUM(NSInteger, GradientStyle){
    GradientStyleLeftToRight = 0,
    GradientStyleRightToLeft,
    GradientStyleTopToBottom,
    GradientStyleBottomToTop,
    GradientStyleLeftTopToRightBottom,
    GradientStyleRightTopToLeftBottom,
    GradientStyleRightBottomToLeftTop,
    GradientStyleLeftBottomToRightTop
};


@interface UIColor (Common)

@property (nonatomic, assign, readonly) CGFloat mRed;
@property (nonatomic, assign, readonly) CGFloat mGreen;
@property (nonatomic, assign, readonly) CGFloat mBlue;
@property (nonatomic, assign, readonly) CGFloat mAlpha;


/**
 十六进制整数初始化

 @param hexInt hexInt
 @return 返回color
 */
+ (UIColor *)colorWithHexInt:(NSInteger)hexInt;

/**
 字符串初始化

 @param hexStr hexStr
 @return 返回color
 */
+ (UIColor *)colorWithHexStr:(NSString *)hexStr;




/**
 生成渐变颜色 默认初始(0, 0), 结束(1, 1), 变化0.5, size正方形

 @param hexs 色值
 @return 返回颜色
 */
+ (UIColor *)gradientWithColors:(NSArray<NSNumber *> *)hexs;

/**
 生成渐变颜色 - 默认初始(0, 0), 结束(1, 1), 变化0.5

 @param size 大小
 @param hexs 色值
 @return 返回颜色
 */
+ (UIColor *)gradientWithSize:(CGSize)size
                       colors:(NSArray<NSNumber *> *)hexs;

/**
 生成渐变颜色

 @param size 大小
 @param style 样式
 @param loc 变化位置
 @param hexs 色值
 @return 返回颜色
 */
+ (UIColor *)gradientWithSize:(CGSize)size
                        style:(GradientStyle)style
                    locations:(NSArray <NSNumber *>*)loc
                       colors:(NSArray<NSNumber *> *)hexs;





/**
 颜色生成图片 -> 默认size(1, 1)

 @return 返回UIImage
 */
- (UIImage *)toImage;

/**
 颜色生成图片

 @param size 大小
 @return 返回UIImage
 */
- (UIImage *)toImageWithSize:(CGSize)size;



@end
