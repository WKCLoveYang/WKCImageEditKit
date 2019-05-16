//
//  UIView+SLCShadow.h
//  AlmightyTest1
//
//  Created by 魏昆超 on 2018/9/14.
//  Copyright © 2018年 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

struct SLCShadow {
    CGSize offset;
    CGFloat blur;
    CGFloat opacity;
    NSInteger colorHex;
    CGFloat cornerRadius;
};

struct SLCCorner {
    UIRectCorner corners;
    CGFloat cornerRadius;
    CGSize size;
};

/**
 创建阴影 - 与View的shadow对应
 
 @param offset 偏移量
 @param blur blur
 @param opacity 透明度
 @param colorHex 色值
 @param cornerRadius 圆角大小
 @return 返回SLCShadow结构体
 */
static inline struct SLCShadow SLCShadowMake(CGSize offset,CGFloat blur,CGFloat opacity,NSInteger colorHex,CGFloat cornerRadius)
{
    struct SLCShadow shadow;
    shadow.offset = offset;
    shadow.blur = blur;
    shadow.opacity = opacity;
    shadow.colorHex = colorHex;
    shadow.cornerRadius = cornerRadius;
    return shadow;
}

/**
 创建圆角 - 与View的corner对应
 
 @param corners 圆角范围
 @param cornerRadius 圆角值
 @param size 范围
 @return 返回SLCCorner结构体
 */
static inline struct SLCCorner SLCCornerMake(UIRectCorner corners,CGFloat cornerRadius,CGSize size)
{
    struct SLCCorner corner;
    corner.corners = corners;
    corner.cornerRadius = cornerRadius;
    corner.size = size;
    return corner;
}


@interface UIView (SLCShadow)

@property (nonatomic, assign) struct SLCShadow shadow; //阴影
@property (nonatomic, assign) struct SLCCorner corner; //圆角

@end

