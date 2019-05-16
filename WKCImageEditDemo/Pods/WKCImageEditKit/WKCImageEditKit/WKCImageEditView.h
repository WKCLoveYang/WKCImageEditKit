//
//  WKCImageEditView.h
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/16.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKCTextItemView.h" // Text
#import "UIImage+Resize.h" // Resize
#import "WKCToneCurveView.h" //WKCToneCurveView
#import "UIImage+Adjustment.h" //Adjustment
#import "UIImage+Flip.h" //Flip
#import "UIImage+Filter.h" //Filter
#import "WKCCutView.h" //Cut
#import "WKCStickerItemView.h" //Sticker
#import "WKCDrawContentView.h" //Draw

@class WKCImageEditView;

@protocol WKCImageEditViewTextDelegate <NSObject>

@optional;
// Text
// 达到了个数限制
- (void)textDidReachLimit:(WKCImageEditView *)imageEdit;
// 点击了左下角
- (void)textDidTapLeftBottom:(WKCImageEditView *)imageEdit;
// 点击了右上角
- (void)textDidTapRightTop:(WKCImageEditView *)imageEdit;
// 点击内容
- (void)textDidTapContent:(WKCImageEditView *)imageEdit;

@end




@protocol WKCImageEditViewToneCurveDelegate <NSObject>

- (UIImage *)toneCurveOriginImage:(WKCImageEditView *)imageEdit;
- (void)toneCurve:(WKCImageEditView *)imageEdit didtoneCurved:(UIImage *)newImage;

@end



@protocol WKCImageEditViewStickerDelegate <NSObject>

@optional;
// 到达数量界限
- (void)stickerDidReachLimit:(WKCImageEditView *)imageEdit;
// 点击了左下角
- (void)stickerDidTapLeftBottom:(WKCImageEditView *)imageEdit;
// 点击了右上角
- (void)stickerDidTapRightTop:(WKCImageEditView *)imageEdit;


@end



@interface WKCImageEditView : UIView

// 区分各个功能, 代理分开
@property (nonatomic, weak) id<WKCImageEditViewTextDelegate> textDelegate;
@property (nonatomic, weak) id<WKCImageEditViewToneCurveDelegate> toneDelegate;
@property (nonatomic, weak) id<WKCImageEditViewStickerDelegate> stickerDelegate;

// Content
@property (nonatomic, strong) UIImage * contentImage;
@property (nonatomic, strong, readonly) UIImageView * contentImageView;
@property (nonatomic, strong, readonly) UIImage * currentImage;
@property (nonatomic, assign) BOOL isBoundaryClip; //超出边界是否裁剪, 默认YES

- (void)reCall; //撤销
- (void)confirm; //确定




// Text
@property (nonatomic, strong) NSAttributedString * textString; //赋值后会增加一个文案
@property (nonatomic, strong) UIImage * textRorationImage; //旋转icon
@property (nonatomic, strong) UIImage * textDeleteImage; //deleteicon
@property (nonatomic, strong) UIImage * textLeftBottomImage; //左下角icon
@property (nonatomic, strong) UIImage * textRightTopImage; //视图
@property (nonatomic, assign) BOOL textIsBorderContinue; //边框是否锯齿
@property (nonatomic, assign) CGFloat textBorderWidth; //边框宽度
@property (nonatomic, strong) UIColor * textBorderColor; //边框颜色
@property (nonatomic, assign) CGFloat textMinScale; //最小比例, 默认0.5
@property (nonatomic, assign) CGFloat textMaxScale; //最大比例, 默认2.0
@property (nonatomic, assign) NSInteger textLimitCount; //最多可以有几个文案, 默认5
// 刷新文案
- (void)refreshTextString:(NSAttributedString *)textString;



// Resize
@property (nonatomic, assign) CGSize resizeImageSize; //更改图片size



// Adjustment
@property (nonatomic, assign) CGFloat adjustmentExposure; //曝光(-1,1), 默认0
@property (nonatomic, assign) CGFloat adjustmentBrightness; //亮度(-1,1), 默认0
@property (nonatomic, assign) CGFloat adjustmentContrast; //对比度(0,4), 默认1
@property (nonatomic, assign) CGFloat adjustmentSaturation; //饱和度(0,2), 默认1
@property (nonatomic, assign) CGFloat adjustmentIntensity; //色温(0,1), 默认1
@property (nonatomic, assign) CGFloat adjustmentAngle; //色调(-3.14,3.14), 默认0
@property (nonatomic, assign) CGFloat adjustmentBlur; //模糊(0,100), 默认10
@property (nonatomic, assign) CGFloat adjustmentShadow; //阴影高亮(0.3,1), 默认1





// Flip
- (void)flipFixOrientation; // 修正方向
- (void)flipVertical; //垂直方向翻转
- (void)flipHorizontal; //水平方向翻转
- (void)flipByDegrees:(CGFloat)degrees; // 按角度旋转 例如 90






// Filter
- (void)filterWithType:(UIImageFilterType)type;






// Sticker
@property (nonatomic, strong) UIImage * stickerImage; //贴图, 赋值及增加一个贴图
@property (nonatomic, strong) UIImage * stickerRorationImage; //旋转Icon
@property (nonatomic, strong) UIImage * stickerDeleteImage; //delegateIcon
@property (nonatomic, strong) UIImage * stickerLeftBottomImage; //左下角icon
@property (nonatomic, strong) UIImage * stickerRightTopImage; //右上角icon
@property (nonatomic, assign) BOOL stickerIsBorderContinue; //是否锯齿
@property (nonatomic, assign) CGFloat stickerBorderWidth; //边框宽度
@property (nonatomic, strong) UIColor * stickerBorderColor; //边框颜色
@property (nonatomic, assign) CGFloat stickerMinScale; //最小比例, 默认0.5
@property (nonatomic, assign) CGFloat stickerMaxScale; //最大比例, 默认2.0
@property (nonatomic, assign) NSInteger stickerLimitCount; //最多可以有几个贴纸, 默认5





// Draw
@property (nonatomic, assign) BOOL drawCouldUse; //是否开启画笔
@property (nonatomic, strong) UIColor * drawLineColor; //画笔颜色
@property (nonatomic, assign) CGFloat drawLineWidth; //画笔宽度

- (void)drawClear; //清屏draw
- (void)drawRevoke; //撤销
- (void)drawErase; //擦除功能开启






// ToneCurve 如果不符合自己的UI要求, 可以使用WKCToneCurveView完全自定义, 再添加到当前视图即可.
@property (nonatomic, assign) BOOL toneCouldUse; //是否tone
@property (nonatomic, strong) UIColor * toneGridColor; //网格颜色, 默认黑色
@property (nonatomic, assign) CGFloat toneGridWidth; //网格宽度, 默认1
@property (nonatomic, strong) UIColor * tonePointColor; //点颜色, 默认黑色
@property (nonatomic, strong) UIColor * toneLineColor; //线框颜色
@property (nonatomic, assign) CGFloat toneLineWidth; //线框宽度






// Cut 如果不符合自己的UI要求,使用WKCCutView完全自定义, 再添加到当前视图即可.
@property (nonatomic, assign) BOOL cutCouldUse; //是否开启cut功能
@property (nonatomic, assign) BOOL cutNeedScaleCrop; // 是否需要按比例裁剪
@property (nonatomic, assign) BOOL cutShowMidLines; // 是否需要展示四边中间的凸起
@property (nonatomic, assign) BOOL cutShowCrossLines; // 是否显示交叉线
@property (nonatomic, assign) BOOL cutCornerBorderInImage; // 边框的四个角是否可以超出图片显示
@property (nonatomic, assign) CGFloat cutCropAspectRatio; // 裁剪框的宽高比
@property (nonatomic, strong) UIColor * cutCropAreaBorderLineColor; // 边框的颜色
@property (nonatomic, assign) CGFloat cutCropAreaBorderLineWidth; // 边框的线宽
@property (nonatomic, strong) UIColor * cutCropAreaCornerLineColor; // 边框四个角的颜色
@property (nonatomic, assign) CGFloat cutCropAreaCornerLineWidth; // 边框四个角的线宽
@property (nonatomic, assign) CGFloat cutCropAreaCornerWidth; // 边框四个角的宽度，这里指角的横边的长度
@property (nonatomic, assign) CGFloat cutCropAreaCornerHeight; // 边框四个角的高度，这里指角的竖边的长度
@property (nonatomic, assign) CGFloat cutMinSpace; //相邻角之间的最小距离
@property (nonatomic, assign) CGFloat cutCropAreaCrossLineWidth; //交叉线的宽度
@property (nonatomic, strong) UIColor * cutCropAreaCrossLineColor; //交叉线的颜色
@property (nonatomic, assign) CGFloat cutCropAreaMidLineWidth; //边框每条边中间线的长度
@property (nonatomic, assign) CGFloat cutCropAreaMidLineHeight; //边框每条边中间线的线宽
@property (nonatomic, assign) UIColor * cutCropAreaMidLineColor; //边框每条边中间线的颜色
@property (nonatomic, strong) UIColor * cutMaskColor; //裁剪区域的蒙板颜色。




@end
