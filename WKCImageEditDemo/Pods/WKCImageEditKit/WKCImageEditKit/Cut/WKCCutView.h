//
//  WKCCutView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKCCropAreaCornerStyle) {
    WKCCropAreaCornerStyleRightAngle,
    WKCCropAreaCornerStyleCircle
};

@interface WKCCutView : UIView

// 需要裁剪的源图
@property (nonatomic, strong) UIImage * cropImage;
// 是否需要按比例裁剪
@property (nonatomic, assign) BOOL needScaleCrop;
// 是否需要展示四边中间的凸起
@property (nonatomic, assign) BOOL showMidLines;
// 是否显示交叉线
@property (nonatomic, assign) BOOL showCrossLines;
// 边框的四个角是否可以超出图片显示
@property (nonatomic, assign) BOOL cornerBorderInImage;
// 裁剪框的宽高比
@property (nonatomic, assign) CGFloat cropAspectRatio;
// 边框的颜色
@property (nonatomic, strong) UIColor * cropAreaBorderLineColor;
// 边框的线宽
@property (nonatomic, assign) CGFloat cropAreaBorderLineWidth;
// 边框四个角的颜色
@property (nonatomic, strong) UIColor * cropAreaCornerLineColor;
// 边框四个角的线宽
@property (nonatomic, assign) CGFloat cropAreaCornerLineWidth;
// 边框四个角的宽度，这里指角的横边的长度
@property (nonatomic, assign) CGFloat cropAreaCornerWidth;
// 边框四个角的高度，这里指角的竖边的长度
@property (nonatomic, assign) CGFloat cropAreaCornerHeight;
// 相邻角之间的最小距离
@property (nonatomic, assign) CGFloat minSpace;
// 交叉线的宽度
@property (nonatomic, assign) CGFloat cropAreaCrossLineWidth;
// 交叉线的颜色
@property (nonatomic, strong) UIColor * cropAreaCrossLineColor;
// 边框每条边中间线的长度
@property (nonatomic, assign) CGFloat cropAreaMidLineWidth;
// 边框每条边中间线的线宽
@property (nonatomic, assign) CGFloat cropAreaMidLineHeight;
// 边框每条边中间线的颜色
@property (nonatomic, assign) UIColor *cropAreaMidLineColor;
// 裁剪区域的蒙板颜色。
@property (nonatomic, strong) UIColor * maskColor;
// 比例
@property (nonatomic, assign) CGFloat initialScaleFactor;
// 裁剪后的图片
@property (nonatomic, strong, readonly) UIImage * currentCroppedImage;

@end
