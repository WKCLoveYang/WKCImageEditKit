//
//  WKCImageEditView.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/16.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCImageEditView.h"

@interface UIView (Common)

/**
 视图转image
 */
@property (nonatomic, strong, readonly) UIImage * toImage;

@end

@implementation UIView (Common)

- (UIImage *)toImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, UIScreen.mainScreen.scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end









@interface WKCImageEditView()
<WKCTextEditorDelegate,
WKCTextItemViewDataSource,
WKCStcikerEditorDelegate,
WKCStickerItemViewDataSource,
WKCToneCurveViewDelegate>
{
    NSInteger _currentTextCount; //当前text个数
    CGFloat _textMaxWidth; //text宽限制
    
    CGFloat _stickerWidth; //贴图宽
    CGFloat _stickerHeight; //贴图高
    NSInteger _stickerCount; //贴图个数
}

@property (nonatomic, strong) UIImageView * contentImageView;
@property (nonatomic, strong) WKCTextItemView * currentTextItem;
@property (nonatomic, strong) WKCStickerItemView * currentStickerItem;
@property (nonatomic, strong) WKCDrawContentView * drawView;
@property (nonatomic, strong) WKCToneCurveView * toneView;
@property (nonatomic, strong) WKCCutView * cutView;

@end

@implementation WKCImageEditView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self wkc_initPararms];
        
        [self addSubview:self.contentImageView];
        [self wkc_setupLayout];
    }
    
    return self;
}

- (void)wkc_initPararms
{
    self.isBoundaryClip = YES;
    
    // Text
    _currentTextCount = 0;
    _textLimitCount = 5;
    _textIsBorderContinue = NO;
    _textBorderWidth = 2;
    _textBorderColor = UIColor.whiteColor;
    _textMinScale = 0.5;
    _textMaxScale = 2;
    
    // Adjustment
    _adjustmentExposure = 0;
    _adjustmentBrightness = 0;
    _adjustmentContrast = 1;
    _adjustmentSaturation = 1;
    _adjustmentIntensity = 1;
    _adjustmentAngle = 0;
    _adjustmentBlur = 10;
    _adjustmentShadow = 1;
    
    _stickerCount = 0;
    _stickerLimitCount = 5;
    _stickerIsBorderContinue = NO;
    _stickerBorderWidth = 2;
    _stickerBorderColor = UIColor.whiteColor;
    _stickerMinScale = 0.5;
    _stickerMaxScale = 2;
    
}


- (void)wkc_setupLayout
{
    _contentImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:_contentImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:_contentImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:_contentImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:_contentImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self addConstraint:top];
    [self addConstraint:bottom];
    [self addConstraint:left];
    [self addConstraint:right];
}


- (void)setContentImage:(UIImage *)contentImage
{
    _contentImage = contentImage;
    
    [self.superview layoutIfNeeded];
    [self layoutIfNeeded];
    
    self.contentImageView.image = contentImage;
    
    CGFloat imageWidth = contentImage.size.width;
    CGFloat imageHeight = contentImage.size.height;
    
    CGFloat drawWidth = CGRectGetWidth(self.frame);
    CGFloat drawHeight = CGRectGetHeight(self.frame);
    
    _resizeImageSize = CGSizeMake(imageWidth, imageHeight);
    _stickerWidth = drawWidth / 2.0;
    _stickerHeight = drawHeight / 2.0;
    _textMaxWidth = drawWidth  - 30;
    
    if (drawHeight / drawWidth < imageHeight / imageWidth) // 等高
    {
        self.contentImageView.bounds = CGRectMake(0, 0, drawHeight * imageWidth / imageHeight, drawHeight);
    }
    else // 等宽
    {
        self.contentImageView.bounds = CGRectMake(0, 0, drawWidth, drawWidth * imageHeight / imageWidth);
    }
    
    
    // 使用了text
    if (_currentTextItem)
    {
        _currentTextItem.center = CGPointMake(_contentImageView.bounds.size.width / 2.0, _contentImageView.bounds.size.height / 2.0);
    }
    
    if (_currentStickerItem)
    {
        _currentStickerItem.center = CGPointMake(_contentImageView.bounds.size.width / 2.0, _contentImageView.bounds.size.height / 2.0);
    }
    
}

- (UIImage *)currentImage
{
    // 取消所有贴图的选中状态
    for (UIView * view in _contentImageView.subviews)
    {
        if ([view isKindOfClass:WKCTextItemView.class])
        {
            WKCTextItemView * sticker = (WKCTextItemView *)view;
            sticker.shouldActivity = NO;
        }
        
        if ([view isKindOfClass:WKCStickerItemView.class])
        {
            WKCStickerItemView * item = (WKCStickerItemView *)view;
            item.shouldActivity = NO;
        }
    }
    
    // 保存
    if (!_contentImageView.image)
    {
        _contentImageView.image = [self imageWithColor:UIColor.clearColor];
    }
    
    return _contentImageView.toImage;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setIsBoundaryClip:(BOOL)isBoundaryClip
{
    _isBoundaryClip = isBoundaryClip;
    
    self.contentImageView.layer.masksToBounds = isBoundaryClip;
}

- (void)reCall
{
    self.contentImageView.image = self.contentImage;
}
- (void)confirm
{
    self.contentImageView.image = self.currentImage;
}






/**********************Text*****************************/
- (void)setTextString:(NSAttributedString *)textString
{
    _textString = textString;
    
    if (_currentTextCount >= self.textLimitCount) // 达到了个数限制
    {
        if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(textDidReachLimit:)])
        {
            [self.textDelegate textDidReachLimit:self];
        }
        
        return;
    }
    
    // 取消原来的选中状态
    self.currentTextItem.shouldActivity = NO;
    
    NSRange range = NSMakeRange(0, textString.length);
    NSDictionary * dic = [textString attributesAtIndex:0 effectiveRange:&range];
    
    CGFloat currentWidth = [textString.string boundingRectWithSize:CGSizeMake(MAXFLOAT, 50) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    
    CGFloat width = 0, height = 0;
    
    if (currentWidth < _textMaxWidth)
    {
        width = currentWidth + 20;
        height = 50;
    }
    else
    {
        CGFloat currentHeight = [textString.string boundingRectWithSize:CGSizeMake(_textMaxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
        width = _textMaxWidth;
        height = currentHeight + 20;
    }
    
    WKCTextItemView * item = [[WKCTextItemView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    item.center = CGPointMake(_contentImageView.bounds.size.width / 2.0, _contentImageView.bounds.size.height / 2.0);
    item.textLimitWidth = _textMaxWidth;
    item.contentString = textString;
    item.isBorderContinue = _textIsBorderContinue;
    item.borderWidth = _textBorderWidth;
    item.borderColor = _textBorderColor;
    item.minScale = _textMinScale;
    item.maxScale = _textMaxScale;
    item.delegate = self;
    item.dataSource = self;
    item.tag = _currentTextCount;
    [_contentImageView addSubview:item];
    
    _currentTextItem = item;
    _currentTextCount ++;
}

- (void)refreshTextString:(NSAttributedString *)textString
{
    NSRange range = NSMakeRange(0, textString.length);
    NSDictionary * dic = [textString attributesAtIndex:0 effectiveRange:&range];
    
    CGFloat currentWidth = [textString.string boundingRectWithSize:CGSizeMake(MAXFLOAT, 50) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    
    CGFloat width = 0, height = 0;
    
    if (currentWidth < _textMaxWidth)
    {
        width = currentWidth + 20;
        height = 50;
    }
    else
    {
        CGFloat currentHeight = [textString.string boundingRectWithSize:CGSizeMake(_textMaxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
        width = _textMaxWidth;
        height = currentHeight + 20;
    }
    
    _currentTextItem.bounds = CGRectMake(0, 0, width, height);
    _currentTextItem.contentString = textString;
}

- (UIImage *)textViewRorationImage:(WKCTextItemView *)textView
{
    return _textRorationImage;
}

- (UIImage *)textViewDeleteImage:(WKCTextItemView *)textView
{
    return _textDeleteImage;
}

- (UIImage *)textViewLeftBottomImage:(WKCTextItemView *)textView
{
    return _textLeftBottomImage;
}

- (UIImage *)textViewRightTopImage:(WKCTextItemView *)textView
{
    return _textRightTopImage;
}

#pragma mark -✨WKCTextEditorDelegate
- (void)textEditorDidTapContentView:(WKCTextEditor *)textEditor
{
    if (_currentTextItem.isControlActivity)
    {
        _currentTextItem.shouldActivity = NO;
    }
    
    _currentTextItem = (WKCTextItemView *)textEditor;
    _currentTextItem.shouldActivity = YES;
    
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(textDidTapContent:)])
    {
        [self.textDelegate textDidTapContent:self];
    }
    
}

- (void)textEditorDidTapDeleteControl:(WKCTextEditor *)textEditor
{
    _currentTextCount --;
}

- (void)textEditorDidTapLeftBottomControl:(WKCTextEditor *)textEditor
{
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(textDidTapLeftBottom:)])
    {
        [self.textDelegate textDidTapLeftBottom:self];
    }
}

- (void)textEditorDidTapRightTopControl:(WKCTextEditor *)textEditor
{
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(textDidTapRightTop:)])
    {
        [self.textDelegate textDidTapRightTop:self];
    }
}

// 辞退键盘
- (void)callBackKeyboard
{
    [self.currentTextItem resignKeyboard];
}





/**********************Resize*****************************/
- (void)setResizeImageSize:(CGSize)resizeImageSize
{
    _resizeImageSize = resizeImageSize;
    self.contentImage = [self.contentImage imageScalingToSize:resizeImageSize];
}






/**********************Adjustment*****************************/
- (void)setAdjustmentExposure:(CGFloat)adjustmentExposure
{
    _adjustmentExposure = adjustmentExposure;
    _contentImageView.image = [_contentImageView.image exposureWithValue:adjustmentExposure];
}

- (void)setAdjustmentBrightness:(CGFloat)adjustmentBrightness
{
    _adjustmentBrightness = adjustmentBrightness;
    _contentImageView.image = [_contentImageView.image brightnessWithValue:adjustmentBrightness];
}

- (void)setAdjustmentContrast:(CGFloat)adjustmentContrast
{
    _adjustmentContrast = adjustmentContrast;
    _contentImageView.image = [_contentImageView.image contrastWithValue:adjustmentContrast];
}

- (void)setAdjustmentSaturation:(CGFloat)adjustmentSaturation
{
    _adjustmentSaturation = adjustmentSaturation;
    _contentImageView.image = [_contentImageView.image saturationWithValue:adjustmentSaturation];
}

- (void)setAdjustmentIntensity:(CGFloat)adjustmentIntensity
{
    _adjustmentIntensity = adjustmentIntensity;
    _contentImageView.image = [_contentImageView.image intensityWithValue:adjustmentIntensity];
}

- (void)setAdjustmentAngle:(CGFloat)adjustmentAngle
{
    _adjustmentAngle = adjustmentAngle;
    _contentImageView.image = [_contentImageView.image angleWithValue:adjustmentAngle];
}

- (void)setAdjustmentBlur:(CGFloat)adjustmentBlur
{
    _adjustmentBlur = adjustmentBlur;
    _contentImageView.image = [_contentImageView.image blurWithValue:adjustmentBlur];
}

- (void)setAdjustmentShadow:(CGFloat)adjustmentShadow
{
    _adjustmentShadow = adjustmentShadow;
    _contentImageView.image = [_contentImageView.image highlightShadowWithValue:adjustmentShadow];
}




/**********************Flip*****************************/
- (void)flipFixOrientation
{
    self.contentImageView.image = [self.contentImageView.image fixOrientation];
}

- (void)flipVertical
{
    self.contentImageView.image = [self.contentImageView.image flipVertical];
}

- (void)flipHorizontal
{
    self.contentImageView.image = [self.contentImageView.image flipHorizontal];
}

- (void)flipByDegrees:(CGFloat)degrees
{
    self.contentImageView.image = [self.contentImageView.image imageRotatedByDegrees:degrees];
}






/**********************Filter*****************************/
- (void)filterWithType:(UIImageFilterType)type
{
    self.contentImageView.image = [self.contentImageView.image filterWithType:type];
}




/**********************Sticker*****************************/
- (void)setStickerImage:(UIImage *)stickerImage
{
    _stickerImage = stickerImage;
    
    if (_stickerCount >= self.stickerLimitCount)
    {
        if (self.stickerDelegate && [self.stickerDelegate respondsToSelector:@selector(stickerDidReachLimit:)])
        {
            [self.stickerDelegate stickerDidReachLimit:self];
        }
        
        return;
    }
    
    // 取消原来的选中状态
    self.currentStickerItem.shouldActivity = NO;
    
    CGFloat imageWidth = stickerImage.size.width;
    CGFloat imageHeight = stickerImage.size.height;
    
    if (imageHeight > imageWidth)
    {
        _stickerWidth = imageWidth / imageHeight * _stickerHeight;
    }
    else
    {
        _stickerHeight = imageHeight / imageWidth * _stickerWidth;
    }
    
    WKCStickerItemView * item = [[WKCStickerItemView alloc] initWithContentFrame:CGRectMake(0, 0, _stickerWidth, _stickerHeight) contentImage:stickerImage];
    item.center = CGPointMake(_contentImageView.bounds.size.width / 2.0, _contentImageView.bounds.size.height / 2.0);
    item.isBorderContinue = _stickerIsBorderContinue;
    item.borderWidth = _stickerBorderWidth;
    item.borderColor = _stickerBorderColor;
    item.minScale = _stickerMinScale;
    item.maxScale = _stickerMaxScale;
    item.delegate = self;
    item.dataSource = self;
    item.tag = _stickerCount;
    [_contentImageView addSubview:item];
    
    _currentStickerItem = item;
    _stickerCount ++;
}

- (UIImage *)stickerViewRorationImage:(WKCStickerItemView *)stickerView
{
    return _stickerRorationImage;
}

- (UIImage *)stickerViewDeleteImage:(WKCStickerItemView *)stickerView
{
    return _stickerDeleteImage;
}

- (UIImage *)stickerViewLeftBottomImage:(WKCStickerItemView *)stickerView
{
    return _stickerLeftBottomImage;
}

- (UIImage *)stickerViewRightTopImage:(WKCStickerItemView *)stickerView
{
    return _stickerRightTopImage;
}

- (void)stickerEditorDidTapContentView:(WKCStcikerEditor *)stcikerEditor
{
    if (_currentStickerItem.isControlActivity)
    {
        _currentStickerItem.shouldActivity = NO;
    }
    
    _currentStickerItem = (WKCStickerItemView *)stcikerEditor;
    _currentStickerItem.shouldActivity = YES;
}

- (void)stickerEditorDidTapDeleteControl:(WKCStcikerEditor *)stcikerEditor
{
    _stickerCount --;
}

- (void)stickerEditorDidTapLeftBottomControl:(WKCStcikerEditor *)stcikerEditor
{
    if (self.stickerDelegate && [self.stickerDelegate respondsToSelector:@selector(stickerDidTapLeftBottom:)])
    {
        [self.stickerDelegate stickerDidTapLeftBottom:self];
    }
}

- (void)stickerEditorDidTapRightTopControl:(WKCStcikerEditor *)stcikerEditor
{
    if (self.stickerDelegate && [self.stickerDelegate respondsToSelector:@selector(stickerDidTapRightTop:)])
    {
        [self.stickerDelegate stickerDidTapRightTop:self];
    }
}







/**********************Sticker*****************************/
- (void)setDrawCouldUse:(BOOL)drawCouldUse
{
    _drawCouldUse = drawCouldUse;
    if (drawCouldUse)
    {
        self.drawView.frame = _contentImageView.bounds;
        if (!_drawView.superview) [_contentImageView addSubview:_drawView];
    }
    else
    {
        [self.drawView removeFromSuperview];
    }
}

- (void)setDrawLineColor:(UIColor *)drawLineColor
{
    _drawLineColor = drawLineColor;
    self.drawView.lineColor = drawLineColor;
}

- (void)setDrawLineWidth:(CGFloat)drawLineWidth
{
    _drawLineWidth = drawLineWidth;
    self.drawView.lineWidth = drawLineWidth;
}

- (void)drawClear
{
    [self.drawView clear];
}

- (void)drawRevoke
{
    [self.drawView revoke];
}

- (void)drawErase
{
    [self.drawView erase];
}






/**********************ToneCurve*****************************/
- (void)setToneCouldUse:(BOOL)toneCouldUse
{
    _toneCouldUse = toneCouldUse;
    if (toneCouldUse)
    {
        _toneView = [[WKCToneCurveView alloc] initWithFrame:CGRectMake(0, 0, _contentImageView.bounds.size.height - 20, _contentImageView.bounds.size.height - 20) pointSize:CGSizeMake(10, 10)];
        if (_toneGridColor) _toneView.gridColor = _toneGridColor;
        if (_toneGridWidth) _toneView.gridWidth = _toneGridWidth;
        if (_tonePointColor) _toneView.pointColor = _tonePointColor;
        if (_toneLineColor) _toneView.lineColor = _toneLineColor;
        if (_toneLineWidth) _toneView.lineWidth = _toneLineWidth;
        _toneView.delegate = self;
        _toneView.center = CGPointMake(_contentImageView.bounds.size.width / 2.0, _contentImageView.bounds.size.height / 2.0);
        if (!_toneView.superview) [_contentImageView addSubview:_toneView];
    }
    else
    {
        [_toneView removeFromSuperview];
    }
}

- (UIImage *)toneCurveViewOriginImage:(WKCToneCurveView *)toneCurveView
{
    return _contentImageView.image;
}

- (void)toneCurveView:(WKCToneCurveView *)toneCurveView didtoneCurved:(UIImage *)newImage
{
    _contentImageView.image = newImage;
}




/**********************Cut*****************************/
- (void)setCutCouldUse:(BOOL)cutCouldUse
{
    _cutCouldUse = cutCouldUse;
    if (cutCouldUse)
    {
        _cutView = [[WKCCutView alloc] initWithFrame:self.bounds];
        _cutView.cropImage = _contentImage;
        _cutView.showMidLines = _cutShowMidLines;
        _cutView.needScaleCrop = _cutNeedScaleCrop;
        _cutView.showCrossLines = _cutShowCrossLines;
        _cutView.cornerBorderInImage = _cutCornerBorderInImage;
        _cutView.cropAreaCornerWidth = _cutCropAreaCornerWidth ?: 44;
        _cutView.cropAreaCornerHeight = _cutCropAreaCornerHeight ?: 44;
        _cutView.minSpace = _cutMinSpace ?: 30;
        _cutView.cropAreaCornerLineColor = _cutCropAreaCornerLineColor ?: [UIColor whiteColor];
        _cutView.cropAreaBorderLineColor = _cutCropAreaBorderLineColor ?: [UIColor whiteColor];
        _cutView.cropAreaCornerLineWidth = _cutCropAreaCornerLineWidth ?: 6;
        _cutView.cropAreaBorderLineWidth = _cutCropAreaBorderLineWidth ?: 4;
        _cutView.cropAreaMidLineWidth = _cutCropAreaMidLineWidth ?: 20;
        _cutView.cropAreaMidLineHeight = _cutCropAreaMidLineHeight ?: 6;
        _cutView.cropAreaMidLineColor = _cutCropAreaMidLineColor ?: [UIColor whiteColor];
        _cutView.cropAreaCrossLineColor = _cutCropAreaCrossLineColor ?: [UIColor whiteColor];
        _cutView.cropAreaCrossLineWidth = _cutCropAreaCrossLineWidth ?: 4;
        _cutView.initialScaleFactor = .8f;
        _cutView.cropAspectRatio = 1;
        if (!_cutView.superview) [self addSubview:_cutView];
    }
    else
    {
        [_cutView removeFromSuperview];
    }
}

- (void)setCutCropAspectRatio:(CGFloat)cutCropAspectRatio
{
    _cutCropAspectRatio = cutCropAspectRatio;
    _cutView.cropAspectRatio = cutCropAspectRatio;
}





/**********************Blend*****************************/
- (void)blendWithFront:(UIImage *)front
                 alpha:(CGFloat)alpha
             blendMode:(WKCBlendMode)mode
{
    self.contentImageView.image = [self.contentImageView.image
                                   imageWithFront:front
                                   alpha:alpha
                                   blendMode:mode];
}

#pragma mark -🌲Property
- (UIImageView *)contentImageView
{
    if (!_contentImageView)
    {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _contentImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThisView)];
        _contentImageView.userInteractionEnabled = YES;
        [_contentImageView addGestureRecognizer:tap];
    }
    
    return _contentImageView;
}

- (void)tapThisView
{
    if (self.currentTextItem) [self callBackKeyboard];
    
    for (UIView * sub in _contentImageView.subviews)
    {
        if ([sub isKindOfClass:WKCTextItemView.class])
        {
            WKCTextItemView * item = (WKCTextItemView *)sub;
            item.shouldActivity = NO;
        }
        
        if ([sub isKindOfClass:WKCStickerItemView.class])
        {
            WKCStickerItemView * item = (WKCStickerItemView *)sub;
            item.shouldActivity = NO;
        }
    }
}

- (WKCDrawContentView *)drawView
{
    if (!_drawView)
    {
        _drawView = [[WKCDrawContentView alloc] init];
    }
    
    return _drawView;
}

@end
