//
//  WKCCutView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCCutView.h"
#import "UIImage+OrienHandle.h"
#import "WKCCutCornerView.h"
#import "WKCCutMidLineView.h"
#import "WKCCutCropAreaView.h"

@interface WKCCutView()
{
    CGFloat currentMinSpace;
}

@property (nonatomic, strong) UIView *cropMaskView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) WKCCutCornerView * topLeftCorner;
@property (nonatomic, strong) WKCCutCornerView * topRightCorner;
@property (nonatomic, strong) WKCCutCornerView * bottomLeftCorner;
@property (nonatomic, strong) WKCCutCornerView * bottomRightCorner;
@property (nonatomic, strong) WKCCutCropAreaView * cropAreaView;
@property (nonatomic, strong) UIPanGestureRecognizer * topLeftPan;
@property (nonatomic, strong) UIPanGestureRecognizer * topRightPan;
@property (nonatomic, strong) UIPanGestureRecognizer * bottomLeftPan;
@property (nonatomic, strong) UIPanGestureRecognizer * bottomRightPan;
@property (nonatomic, strong) UIPanGestureRecognizer * cropAreaPan;
@property (nonatomic, strong) UIPinchGestureRecognizer * cropAreaPinch;
@property (nonatomic, assign) CGSize pinchOriSize;
@property (nonatomic, assign) CGPoint cropAreaOriCenter;
@property (nonatomic, assign) CGRect cropAreaOriFrame;
@property (nonatomic, strong) WKCCutMidLineView * topMidLine;
@property (nonatomic, strong) WKCCutMidLineView * leftMidLine;
@property (nonatomic, strong) WKCCutMidLineView * bottomMidLine;
@property (nonatomic, strong) WKCCutMidLineView * rightMidLine;
@property (nonatomic, strong) UIPanGestureRecognizer * topMidPan;
@property (nonatomic, strong) UIPanGestureRecognizer * bottomMidPan;
@property (nonatomic, strong) UIPanGestureRecognizer * leftMidPan;
@property (nonatomic, strong) UIPanGestureRecognizer * rightMidPan;
@property (nonatomic, assign) CGFloat paddingLeftRight;
@property (nonatomic, assign) CGFloat paddingTopBottom;
@property (nonatomic, assign) CGFloat imageAspectRatio;
@property (nonatomic, assign, readonly) CGFloat cornerMargin;

@end

@implementation WKCCutView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame: frame])
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if([super initWithCoder: aDecoder])
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self setUp];
    [self createCorners];
    [self resetCropAreaOnCornersFrameChanged];
    [self bindPanGestures];
}

- (void)setUp
{
    _imageView = [[UIImageView alloc]initWithFrame: self.bounds];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.userInteractionEnabled = YES;
    _imageAspectRatio = 0;
    [self addSubview: _imageView];
    
    _cropMaskView = [[UIView alloc]initWithFrame: _imageView.bounds];
    _cropMaskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _cropMaskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_imageView addSubview: _cropMaskView];
    
    UIColor *defaultColor = [UIColor colorWithWhite: 1 alpha: 0.8];
    _cropAreaBorderLineColor = defaultColor;
    _cropAreaCornerLineColor = [UIColor whiteColor];
    _cropAreaBorderLineWidth = 2;
    _cropAreaCornerLineWidth = 4;
    _cropAreaCornerWidth = 20;
    _cropAreaCornerHeight = 20;
    _minSpace = 10;
    currentMinSpace = _minSpace;
    _cropAreaCrossLineWidth = 2;
    _cropAreaCrossLineColor = defaultColor;
    _cropAreaMidLineWidth = 20;
    _cropAreaMidLineHeight = 4;
    _cropAreaMidLineColor = defaultColor;
    _cropAspectRatio = 1;
    
    _cropAreaView = [[WKCCutCropAreaView alloc] init];
    _cropAreaView.borderWidth = _cropAreaBorderLineWidth;
    _cropAreaView.borderColor = _cropAreaBorderLineColor;
    _cropAreaView.crossLineColor = _cropAreaCrossLineColor;
    _cropAreaView.crossLineWidth = _cropAreaCrossLineWidth;
    _cropAreaView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_imageView addSubview: _cropAreaView];
    
    [_cropAreaView addObserver:self
                    forKeyPath:@"frame"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                       context:NULL];
    [_cropAreaView addObserver:self
                    forKeyPath:@"center"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                       context:NULL];
    [_imageView addObserver:self
                 forKeyPath:@"frame"
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                    context:NULL];
    
}

#pragma mark - PanGesture Bind
- (void)bindPanGestures
{
    _topLeftPan = [[UIPanGestureRecognizer alloc]initWithTarget: self action: @selector(handleCornerPan:)];
    _topRightPan = [[UIPanGestureRecognizer alloc]initWithTarget: self action: @selector(handleCornerPan:)];
    _bottomLeftPan = [[UIPanGestureRecognizer alloc]initWithTarget: self action: @selector(handleCornerPan:)];
    _bottomRightPan = [[UIPanGestureRecognizer alloc]initWithTarget: self action: @selector(handleCornerPan:)];
    _cropAreaPan = [[UIPanGestureRecognizer alloc]initWithTarget: self action: @selector(handleCropAreaPan:)];
    
    [_topLeftCorner addGestureRecognizer: _topLeftPan];
    [_topRightCorner addGestureRecognizer: _topRightPan];
    [_bottomLeftCorner addGestureRecognizer: _bottomLeftPan];
    [_bottomRightCorner addGestureRecognizer: _bottomRightPan];
    [_cropAreaView addGestureRecognizer: _cropAreaPan];
}

#pragma mark - PinchGesture CallBack
- (void)handleCropAreaPinch:(UIPinchGestureRecognizer *)pinchGesture
{
    switch (pinchGesture.state)
    {
        case UIGestureRecognizerStateBegan: {
            _pinchOriSize = _cropAreaView.frame.size;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self resetCropAreaByScaleFactor:pinchGesture.scale];
            break;
        }
        default:
            break;
    }
}

#pragma mark - PanGesture CallBack
- (void)handleCropAreaPan:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan: {
            _cropAreaOriCenter = _cropAreaView.center;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [panGesture translationInView: _imageView];
            CGPoint willCenter = CGPointMake(_cropAreaOriCenter.x + translation.x, _cropAreaOriCenter.y + translation.y);
            CGFloat centerMinX = WIDTH(_cropAreaView) / 2.0f + self.cornerMargin * _cornerBorderInImage ;
            CGFloat centerMaxX = WIDTH(_imageView) - WIDTH(_cropAreaView) / 2.0f - self.cornerMargin * _cornerBorderInImage;
            CGFloat centerMinY = HEIGHT(_cropAreaView) / 2.0f + self.cornerMargin * _cornerBorderInImage;
            CGFloat centerMaxY = HEIGHT(_imageView) - HEIGHT(_cropAreaView) / 2.0f - self.cornerMargin * _cornerBorderInImage;
            _cropAreaView.center = CGPointMake(MIN(MAX(centerMinX, willCenter.x), centerMaxX), MIN(MAX(centerMinY, willCenter.y), centerMaxY));
            [self resetCornersOnCropAreaFrameChanged];
            break;
        }
        default:
            break;
    }
}

- (void)handleMidPan:(UIPanGestureRecognizer *)panGesture
{
    WKCCutMidLineView *midLineView = (WKCCutMidLineView *)panGesture.view;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            _cropAreaOriFrame = _cropAreaView.frame;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [panGesture translationInView: _cropAreaView];
            switch (midLineView.type)
            {
                case WKCMidLineTypeTop: {
                    CGFloat minHeight = currentMinSpace + (_cropAreaCornerHeight - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth) * 2;
                    CGFloat maxHeight = CGRectGetMaxY(_cropAreaOriFrame) - (_cropAreaCornerLineWidth - _cropAreaBorderLineWidth) * self.cornerBorderInImage;
                    CGFloat willHeight = MIN(MAX(minHeight, CGRectGetHeight(_cropAreaOriFrame) - translation.y), maxHeight);
                    CGFloat deltaY = willHeight - CGRectGetHeight(_cropAreaOriFrame);
                    _cropAreaView.frame = CGRectMake(CGRectGetMinX(_cropAreaOriFrame), CGRectGetMinY(_cropAreaOriFrame) - deltaY, CGRectGetWidth(_cropAreaOriFrame), willHeight);
                    break;
                }
                case WKCMidLineTypeBottom: {
                    CGFloat minHeight = currentMinSpace + (_cropAreaCornerHeight - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth) * 2;
                    CGFloat maxHeight = HEIGHT(_imageView) - CGRectGetMinY(_cropAreaOriFrame) - (_cropAreaCornerLineWidth - _cropAreaBorderLineWidth) * self.cornerBorderInImage;
                    CGFloat willHeight = MIN(MAX(minHeight, CGRectGetHeight(_cropAreaOriFrame) + translation.y), maxHeight);
                    _cropAreaView.frame = CGRectMake(CGRectGetMinX(_cropAreaOriFrame), CGRectGetMinY(_cropAreaOriFrame), CGRectGetWidth(_cropAreaOriFrame), willHeight);
                    break;
                }
                case WKCMidLineTypeLeft: {
                    CGFloat minWidth = currentMinSpace + (_cropAreaCornerWidth - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth) * 2;
                    CGFloat maxWidth = CGRectGetMaxX(_cropAreaOriFrame) - (_cropAreaCornerLineWidth - _cropAreaBorderLineWidth) * self.cornerBorderInImage;
                    CGFloat willWidth = MIN(MAX(minWidth, CGRectGetWidth(_cropAreaOriFrame) - translation.x), maxWidth);
                    CGFloat deltaX = willWidth - CGRectGetWidth(_cropAreaOriFrame);
                    _cropAreaView.frame = CGRectMake(CGRectGetMinX(_cropAreaOriFrame) - deltaX, CGRectGetMinY(_cropAreaOriFrame), willWidth, CGRectGetHeight(_cropAreaOriFrame));
                    break;
                }
                case WKCMidLineTypeRight: {
                    CGFloat minWidth = currentMinSpace + (_cropAreaCornerWidth - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth) * 2;
                    CGFloat maxWidth = WIDTH(_imageView) - CGRectGetMinX(_cropAreaOriFrame) - (_cropAreaCornerLineWidth - _cropAreaBorderLineWidth) * self.cornerBorderInImage;
                    CGFloat willWidth = MIN(MAX(minWidth, CGRectGetWidth(_cropAreaOriFrame) + translation.x), maxWidth);
                    _cropAreaView.frame = CGRectMake(CGRectGetMinX(_cropAreaOriFrame), CGRectGetMinY(_cropAreaOriFrame), willWidth, CGRectGetHeight(_cropAreaOriFrame));
                    break;
                }
                default:
                    break;
            }
            [self resetCornersOnCropAreaFrameChanged];
            break;
        }
        default:
            break;
    }
}

- (void)handleCornerPan:(UIPanGestureRecognizer *)panGesture
{
    WKCCutCornerView *panView = (WKCCutCornerView *)panGesture.view;
    WKCCutCornerView *relativeViewX = panView.relativeViewX;
    WKCCutCornerView *relativeViewY = panView.relativeViewY;
    CGPoint locationInImageView = [panGesture locationInView: _imageView];
    NSInteger xFactor = MINX(relativeViewY) > MINX(panView) ? -1 : 1;
    NSInteger yFactor = MINY(relativeViewX) > MINY(panView) ? -1 : 1;
    CGFloat approachAspectRatio = 0;
    if(panView == _topLeftCorner) {
        approachAspectRatio = (MINX(panView) + self.cornerMargin) / (MINY(panView) + self.cornerMargin);
    }
    else if(panView == _topRightCorner) {
        approachAspectRatio = (WIDTH(_imageView) - MAXX(panView) + self.cornerMargin) / (MINY(panView) + self.cornerMargin);
    }
    else if(panView == _bottomLeftCorner) {
        approachAspectRatio = (MINX(panView) + self.cornerMargin) / (HEIGHT(_imageView) - MAXY(panView) + self.cornerMargin);
    }
    else if(panView == _bottomRightCorner) {
        approachAspectRatio = (WIDTH(_imageView) - MAXX(panView) + self.cornerMargin) /(HEIGHT(_imageView) - MAXY(panView) + self.cornerMargin);
    }
    
    CGFloat spaceX = MIN(MAX((locationInImageView.x - relativeViewY.center.x) * xFactor + _cropAreaCornerWidth - self.cornerMargin * 2, currentMinSpace + _cropAreaCornerWidth * 2 - self.cornerMargin * 2), xFactor < 0 ? relativeViewY.center.x + _cropAreaCornerWidth / 2.0 - self.cornerMargin * 2 + self.cornerMargin * !_cornerBorderInImage : WIDTH(_imageView) - relativeViewY.center.x + _cropAreaCornerWidth / 2.0 - self.cornerMargin * 2 + self.cornerMargin * !_cornerBorderInImage);
    
    CGFloat spaceY = MIN(MAX((locationInImageView.y - relativeViewX.center.y) * yFactor + _cropAreaCornerHeight - self.cornerMargin * 2, currentMinSpace + _cropAreaCornerHeight * 2 - self.cornerMargin * 2), yFactor < 0 ? relativeViewX.center.y + _cropAreaCornerHeight / 2.0 - self.cornerMargin * 2 + self.cornerMargin * !_cornerBorderInImage : HEIGHT(_imageView) - relativeViewX.center.y + _cropAreaCornerHeight / 2.0 - self.cornerMargin * 2 + self.cornerMargin * !_cornerBorderInImage);
    
    if(_cropAspectRatio > 0) {
        if(_cropAspectRatio >= approachAspectRatio) {
            spaceY = MAX(spaceX / _cropAspectRatio, currentMinSpace + _cropAreaCornerHeight * 2 - self.cornerMargin * 2);
            spaceX = spaceY * _cropAspectRatio;
        }
        else {
            spaceX = MAX(spaceY * _cropAspectRatio, currentMinSpace + _cropAreaCornerWidth * 2 - self.cornerMargin * 2);
            spaceY = spaceX / _cropAspectRatio;
        }
    }
    
    CGFloat centerX = (spaceX - _cropAreaCornerWidth + self.cornerMargin * 2) * xFactor + relativeViewY.center.x;
    CGFloat centerY = (spaceY - _cropAreaCornerHeight + self.cornerMargin * 2) * yFactor + relativeViewX.center.y;
    panView.center = CGPointMake(centerX, centerY);
    relativeViewX.frame = CGRectMake(MINX(panView), MINY(relativeViewX), WIDTH(relativeViewX), HEIGHT(relativeViewX));
    relativeViewY.frame = CGRectMake(MINX(relativeViewY), MINY(panView), WIDTH(relativeViewY), HEIGHT(relativeViewY));
    [self resetCropAreaOnCornersFrameChanged];
    [self resetCropTransparentArea];
}

#pragma mark - Position/Resize Corners&CropArea
- (void)resetCornersOnCropAreaFrameChanged
{
    _topLeftCorner.frame = CGRectMake(MINX(_cropAreaView) - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth, MINY(_cropAreaView) - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth, _cropAreaCornerWidth, _cropAreaCornerHeight);
    _topRightCorner.frame = CGRectMake(MAXX(_cropAreaView) - _cropAreaCornerWidth + _cropAreaCornerLineWidth - _cropAreaBorderLineWidth, MINY(_cropAreaView) - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth, _cropAreaCornerWidth, _cropAreaCornerHeight);
    _bottomLeftCorner.frame = CGRectMake(MINX(_cropAreaView) - _cropAreaCornerLineWidth + _cropAreaBorderLineWidth, MAXY(_cropAreaView) - _cropAreaCornerHeight + _cropAreaCornerLineWidth - _cropAreaBorderLineWidth, _cropAreaCornerWidth, _cropAreaCornerHeight);
    _bottomRightCorner.frame = CGRectMake(MAXX(_cropAreaView) - _cropAreaCornerWidth + _cropAreaCornerLineWidth - _cropAreaBorderLineWidth, MAXY(_cropAreaView) - _cropAreaCornerHeight + _cropAreaCornerLineWidth - _cropAreaBorderLineWidth, _cropAreaCornerWidth, _cropAreaCornerHeight);
}

- (void)resetCropAreaOnCornersFrameChanged
{
    _cropAreaView.frame = CGRectMake(MINX(_topLeftCorner) + self.cornerMargin, MINY(_topLeftCorner) + self.cornerMargin, MAXX(_topRightCorner) - MINX(_topLeftCorner) - self.cornerMargin * 2, MAXY(_bottomLeftCorner) - MINY(_topLeftCorner) - self.cornerMargin * 2);
}

- (void)resetMinSpaceIfNeeded
{
    CGFloat willMinSpace = MIN(WIDTH(_cropAreaView) - _cropAreaCornerWidth * 2 + self.cornerMargin * 2, HEIGHT(_cropAreaView) - _cropAreaCornerHeight * 2 + self.cornerMargin * 2);
    currentMinSpace = MIN(willMinSpace, _minSpace);
}

- (void)resetCropTransparentArea
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect: _imageView.bounds];
    UIBezierPath *clearPath = [[UIBezierPath bezierPathWithRect: _cropAreaView.frame] bezierPathByReversingPath];
    [path appendPath: clearPath];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)_cropMaskView.layer.mask;
    if(!shapeLayer) {
        shapeLayer = [CAShapeLayer layer];
        [_cropMaskView.layer setMask: shapeLayer];
    }
    shapeLayer.path = path.CGPath;
}

- (void)resetCornersOnSizeChanged
{
    [_topLeftCorner updateSizeWithWidth: _cropAreaCornerWidth height: _cropAreaCornerHeight];
    [_topRightCorner updateSizeWithWidth: _cropAreaCornerWidth height: _cropAreaCornerHeight];
    [_bottomLeftCorner updateSizeWithWidth: _cropAreaCornerWidth height: _cropAreaCornerHeight];
    [_bottomRightCorner updateSizeWithWidth: _cropAreaCornerWidth height: _cropAreaCornerHeight];
}

- (void)createCorners
{
    _topLeftCorner = [[WKCCutCornerView alloc]initWithFrame: CGRectMake(0, 0, _cropAreaCornerWidth, _cropAreaCornerHeight) lineColor:_cropAreaCornerLineColor lineWidth: _cropAreaCornerLineWidth];
    _topLeftCorner.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    _topLeftCorner.cornerPosition = WKCCropAreaCornerPositionTopLeft;
    
    _topRightCorner = [[WKCCutCornerView alloc]initWithFrame: CGRectMake(WIDTH(_imageView) -  _cropAreaCornerWidth, 0, _cropAreaCornerWidth, _cropAreaCornerHeight) lineColor: _cropAreaCornerLineColor lineWidth: _cropAreaCornerLineWidth];
    _topRightCorner.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    _topRightCorner.cornerPosition = WKCCropAreaCornerPositionTopRight;
    
    _bottomLeftCorner = [[WKCCutCornerView alloc]initWithFrame: CGRectMake(0, HEIGHT(_imageView) -  _cropAreaCornerHeight, _cropAreaCornerWidth, _cropAreaCornerHeight) lineColor: _cropAreaCornerLineColor lineWidth: _cropAreaCornerLineWidth];
    _bottomLeftCorner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _bottomLeftCorner.cornerPosition = WKCCropAreaCornerPositionBottomLeft;
    
    _bottomRightCorner = [[WKCCutCornerView alloc]initWithFrame: CGRectMake(WIDTH(_imageView) - _cropAreaCornerWidth, HEIGHT(_imageView) -  _cropAreaCornerHeight, _cropAreaCornerWidth, _cropAreaCornerHeight) lineColor: _cropAreaCornerLineColor lineWidth: _cropAreaCornerLineWidth];
    _bottomRightCorner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    _bottomRightCorner.cornerPosition = WKCCropAreaCornerPositionBottomRight;
    
    _topLeftCorner.relativeViewX = _bottomLeftCorner;
    _topLeftCorner.relativeViewY = _topRightCorner;
    
    _topRightCorner.relativeViewX = _bottomRightCorner;
    _topRightCorner.relativeViewY = _topLeftCorner;
    
    _bottomLeftCorner.relativeViewX = _topLeftCorner;
    _bottomLeftCorner.relativeViewY = _bottomRightCorner;
    
    _bottomRightCorner.relativeViewX = _topRightCorner;
    _bottomRightCorner.relativeViewY = _bottomLeftCorner;
    
    [_imageView addSubview: _topLeftCorner];
    [_imageView addSubview: _topRightCorner];
    [_imageView addSubview: _bottomLeftCorner];
    [_imageView addSubview: _bottomRightCorner];
}

- (void)createMidLines
{
    if(_topMidLine && _bottomMidLine && _leftMidLine && _rightMidLine) return;
    _topMidLine = [[WKCCutMidLineView alloc]initWithLineWidth: _cropAreaMidLineWidth lineHeight: _cropAreaMidLineHeight lineColor: _cropAreaMidLineColor];
    _topMidLine.type = WKCMidLineTypeTop;
    
    _bottomMidLine = [[WKCCutMidLineView alloc]initWithLineWidth: _cropAreaMidLineWidth lineHeight: _cropAreaMidLineHeight lineColor: _cropAreaMidLineColor];
    _bottomMidLine.type = WKCMidLineTypeBottom;
    
    _leftMidLine = [[WKCCutMidLineView alloc]initWithLineWidth: _cropAreaMidLineWidth lineHeight: _cropAreaMidLineHeight lineColor: _cropAreaMidLineColor];
    _leftMidLine.type = WKCMidLineTypeLeft;
    
    _rightMidLine = [[WKCCutMidLineView alloc]initWithLineWidth: _cropAreaMidLineWidth lineHeight: _cropAreaMidLineHeight lineColor: _cropAreaMidLineColor];
    _rightMidLine.type = WKCMidLineTypeRight;
    
    _topMidPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(handleMidPan:)];
    [_topMidLine addGestureRecognizer: _topMidPan];
    
    _bottomMidPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(handleMidPan:)];
    [_bottomMidLine addGestureRecognizer: _bottomMidPan];
    
    _leftMidPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(handleMidPan:)];
    [_leftMidLine addGestureRecognizer: _leftMidPan];
    
    _rightMidPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(handleMidPan:)];
    [_rightMidLine addGestureRecognizer: _rightMidPan];
    
    [_cropAreaView addSubview: _topMidLine];
    [_cropAreaView addSubview: _bottomMidLine];
    [_cropAreaView addSubview: _leftMidLine];
    [_cropAreaView addSubview: _rightMidLine];
}

- (void)removeMidLines
{
    [_topMidLine removeFromSuperview];
    [_bottomMidLine removeFromSuperview];
    [_leftMidLine removeFromSuperview];
    [_rightMidLine removeFromSuperview];
    
    _topMidLine = nil;
    _bottomMidLine = nil;
    _leftMidLine = nil;
    _rightMidLine = nil;
}

- (void)resetMidLines
{
    CGFloat lineMargin = _cropAreaMidLineHeight / 2.0 - _cropAreaBorderLineWidth;
    _topMidLine.frame = CGRectMake((WIDTH(_cropAreaView) - MID_LINE_INTERACT_WIDTH) / 2.0, - MID_LINE_INTERACT_HEIGHT / 2.0 - lineMargin, MID_LINE_INTERACT_WIDTH, MID_LINE_INTERACT_HEIGHT);
    _bottomMidLine.frame = CGRectMake((WIDTH(_cropAreaView) - MID_LINE_INTERACT_WIDTH) / 2.0, HEIGHT(_cropAreaView) - MID_LINE_INTERACT_HEIGHT / 2.0 + lineMargin, MID_LINE_INTERACT_WIDTH, MID_LINE_INTERACT_HEIGHT);
    _leftMidLine.frame = CGRectMake(- MID_LINE_INTERACT_WIDTH / 2.0 - lineMargin, (HEIGHT(_cropAreaView) - MID_LINE_INTERACT_HEIGHT) / 2.0, MID_LINE_INTERACT_WIDTH, MID_LINE_INTERACT_HEIGHT);
    _rightMidLine.frame = CGRectMake(WIDTH(_cropAreaView) - MID_LINE_INTERACT_WIDTH / 2.0 + lineMargin, (HEIGHT(_cropAreaView) - MID_LINE_INTERACT_HEIGHT) / 2.0, MID_LINE_INTERACT_WIDTH, MID_LINE_INTERACT_HEIGHT);
}

- (void)resetImageView
{
    CGFloat selfAspectRatio = WIDTH(self) / HEIGHT(self);
    if(_imageAspectRatio > selfAspectRatio) {
        _paddingLeftRight = 0;
        _paddingTopBottom = floor((HEIGHT(self) - WIDTH(self) / _imageAspectRatio) / 2.0);
        _imageView.frame = CGRectMake(0, _paddingTopBottom, WIDTH(self), floor(WIDTH(self) / _imageAspectRatio));
    }
    else {
        _paddingTopBottom = 0;
        _paddingLeftRight = floor((WIDTH(self) - HEIGHT(self) * _imageAspectRatio) / 2.0);
        _imageView.frame = CGRectMake(_paddingLeftRight, 0, floor(HEIGHT(self) * _imageAspectRatio), HEIGHT(self));
    }
}

- (void)resetCropAreaByAspectRatio
{
    if(_imageAspectRatio == 0) return;
    CGFloat tmpCornerMargin = self.cornerMargin * _cornerBorderInImage;
    CGFloat width, height;
    if(_cropAspectRatio == 0) {
        width = (WIDTH(_imageView) - 2 * tmpCornerMargin) * _initialScaleFactor;
        height = (HEIGHT(_imageView) - 2 * tmpCornerMargin) * _initialScaleFactor;
        if(_showMidLines) {
            [self createMidLines];
            [self resetMidLines];
        }
    }
    else {
        [self removeMidLines];
        if(_imageAspectRatio > _cropAspectRatio) {
            height = (HEIGHT(_imageView) - 2 * tmpCornerMargin) * _initialScaleFactor;
            width = height * _cropAspectRatio;
        }
        else {
            width = (WIDTH(_imageView) - 2 * tmpCornerMargin) * _initialScaleFactor;
            height = width / _cropAspectRatio;
        }
    }
    _cropAreaView.frame = CGRectMake((WIDTH(_imageView) - width) / 2.0, (HEIGHT(_imageView) - height) / 2.0, width, height);
    [self resetCornersOnCropAreaFrameChanged];
    [self resetCropTransparentArea];
    [self resetMinSpaceIfNeeded];
}

- (void)resetCropAreaByScaleFactor:(CGFloat)scaleFactor
{
    CGPoint center = _cropAreaView.center;
    CGFloat tmpCornerMargin = self.cornerMargin * _cornerBorderInImage;
    CGFloat width = _pinchOriSize.width * scaleFactor;
    CGFloat height = _pinchOriSize.height * scaleFactor;
    CGFloat widthMax = MIN(WIDTH(_imageView) - center.x - tmpCornerMargin, center.x - tmpCornerMargin) * 2;
    CGFloat widthMin = currentMinSpace + _cropAreaCornerWidth * 2.0 - tmpCornerMargin * 2.0;
    CGFloat heightMax = MIN(HEIGHT(_imageView) - center.y - tmpCornerMargin, center.y - tmpCornerMargin) * 2;
    CGFloat heightMin = currentMinSpace + _cropAreaCornerWidth * 2.0 - tmpCornerMargin * 2;
    
    BOOL isMinimum = NO;
    if(_cropAspectRatio > 1) {
        if(height <= heightMin) {
            height = heightMin;
            width = height * _cropAspectRatio;
            isMinimum = YES;
        }
    }
    else {
        if(width <= widthMin) {
            width = widthMin;
            height = width / (_cropAspectRatio == 0 ? 1 : _cropAspectRatio);
            isMinimum = YES;
        }
    }
    if(!isMinimum) {
        if(_cropAspectRatio == 0) {
            if(width >= widthMax) {
                width = MIN(width, WIDTH(_imageView) - 2 * tmpCornerMargin);
                center.x = center.x > WIDTH(_imageView) / 2.0 ? WIDTH(_imageView) - width / 2.0 - tmpCornerMargin : width / 2.0 + tmpCornerMargin;
            }
            if(height > heightMax) {
                height = MIN(height, HEIGHT(_imageView) - 2 * tmpCornerMargin);
                center.y = center.y > HEIGHT(_imageView) / 2.0 ? HEIGHT(_imageView) - height / 2.0 - tmpCornerMargin : height / 2.0 + tmpCornerMargin;
            }
            
        }
        else if(_imageAspectRatio > _cropAspectRatio) {
            if(height >= heightMax) {
                height = MIN(height, HEIGHT(_imageView) - 2 * tmpCornerMargin);
                center.y = center.y > HEIGHT(_imageView) / 2.0 ? HEIGHT(_imageView) - height / 2.0 - tmpCornerMargin : height / 2.0 + tmpCornerMargin;
            }
            width = height * _cropAspectRatio;
            if(width > widthMax) {
                center.x = center.x > WIDTH(_imageView) / 2.0 ? WIDTH(_imageView) - width / 2.0 - tmpCornerMargin : width / 2.0 + tmpCornerMargin;
            }
        }
        else {
            if(width >= widthMax) {
                width = MIN(width, WIDTH(_imageView) - 2 * tmpCornerMargin);
                center.x = center.x > WIDTH(_imageView) / 2.0 ? WIDTH(_imageView) - width / 2.0 - tmpCornerMargin : width / 2.0 + tmpCornerMargin;
            }
            height = width / _cropAspectRatio;
            if(height > heightMax) {
                center.y = center.y > HEIGHT(_imageView) / 2.0 ? HEIGHT(_imageView) - height / 2.0 - tmpCornerMargin : height / 2.0 + tmpCornerMargin;
            }
        }
    }
    _cropAreaView.bounds = CGRectMake(0, 0, width, height);
    _cropAreaView.center = center;
    [self resetCornersOnCropAreaFrameChanged];
}

#pragma mark - Setter & Getters
- (void)setInitialScaleFactor:(CGFloat)initialScaleFactor
{
    _initialScaleFactor = MIN(1.0f, initialScaleFactor);
}

- (CGFloat)cornerMargin
{
    return _cropAreaCornerLineWidth - _cropAreaBorderLineWidth;
}

- (void)setMaskColor:(UIColor *)maskColor
{
    _maskColor = maskColor;
    _cropMaskView.backgroundColor = maskColor;
}

- (void)setMinSpace:(CGFloat)minSpace
{
    _minSpace = minSpace;
    currentMinSpace = minSpace;
}

- (void)setCropImage:(UIImage *)cropImage
{
    _cropImage = cropImage;
    _imageAspectRatio = cropImage.size.width / cropImage.size.height;
    _imageView.image = cropImage;
    [self resetImageView];
    [self resetCropAreaByAspectRatio];
}

- (void)setNeedScaleCrop:(BOOL)needScaleCrop
{
    if(!_needScaleCrop && needScaleCrop) {
        _cropAreaPinch = [[UIPinchGestureRecognizer alloc]initWithTarget: self action:@selector(handleCropAreaPinch:)];
        [_cropAreaView addGestureRecognizer: _cropAreaPinch];
    }
    else if(_needScaleCrop && !needScaleCrop){
        [_cropAreaView removeGestureRecognizer: _cropAreaPinch];
        _cropAreaPinch = nil;
    }
    _needScaleCrop = needScaleCrop;
}

- (void)setCropAreaCrossLineWidth:(CGFloat)cropAreaCrossLineWidth
{
    _cropAreaCrossLineWidth = cropAreaCrossLineWidth;
    _cropAreaView.crossLineWidth = cropAreaCrossLineWidth;
}

- (void)setCropAreaCrossLineColor:(UIColor *)cropAreaCrossLineColor
{
    _cropAreaCrossLineColor = cropAreaCrossLineColor;
    _cropAreaView.crossLineColor = cropAreaCrossLineColor;
}

- (void)setCropAreaMidLineWidth:(CGFloat)cropAreaMidLineWidth
{
    _cropAreaMidLineWidth = cropAreaMidLineWidth;
    _topMidLine.lineWidth = cropAreaMidLineWidth;
    _bottomMidLine.lineWidth = cropAreaMidLineWidth;
    _leftMidLine.lineWidth = cropAreaMidLineWidth;
    _rightMidLine.lineWidth = cropAreaMidLineWidth;
    if(_showMidLines) {
        [self resetMidLines];
    }
}

- (void)setCropAreaMidLineHeight:(CGFloat)cropAreaMidLineHeight
{
    _cropAreaMidLineHeight = cropAreaMidLineHeight;
    _topMidLine.lineHeight = cropAreaMidLineHeight;
    _bottomMidLine.lineHeight = cropAreaMidLineHeight;
    _leftMidLine.lineHeight = cropAreaMidLineHeight;
    _rightMidLine.lineHeight = cropAreaMidLineHeight;
    if(_showMidLines) {
        [self resetMidLines];
    }
}

- (void)setCropAreaMidLineColor:(UIColor *)cropAreaMidLineColor
{
    _cropAreaMidLineColor = cropAreaMidLineColor;
    _topMidLine.lineColor = cropAreaMidLineColor;
    _bottomMidLine.lineColor = cropAreaMidLineColor;
    _leftMidLine.lineColor = cropAreaMidLineColor;
    _rightMidLine.lineColor = cropAreaMidLineColor;
}

- (void)setCropAreaBorderLineWidth:(CGFloat)cropAreaBorderLineWidth
{
    _cropAreaBorderLineWidth = cropAreaBorderLineWidth;
    _cropAreaView.borderWidth = cropAreaBorderLineWidth;
    [self resetCropAreaOnCornersFrameChanged];
}

- (void)setCropAreaBorderLineColor:(UIColor *)cropAreaBorderLineColor
{
    _cropAreaBorderLineColor = cropAreaBorderLineColor;
    _cropAreaView.borderColor = cropAreaBorderLineColor;
}

- (void)setCropAreaCornerLineColor:(UIColor *)cropAreaCornerLineColor
{
    _cropAreaCrossLineColor = cropAreaCornerLineColor;
    _topLeftCorner.lineColor = cropAreaCornerLineColor;
    _topRightCorner.lineColor = cropAreaCornerLineColor;
    _bottomLeftCorner.lineColor = cropAreaCornerLineColor;
    _bottomRightCorner.lineColor = cropAreaCornerLineColor;
}

- (void)setCropAreaCornerLineWidth:(CGFloat)cropAreaCornerLineWidth
{
    _cropAreaCornerLineWidth = cropAreaCornerLineWidth;
    _topLeftCorner.lineWidth = cropAreaCornerLineWidth;
    _topRightCorner.lineWidth = cropAreaCornerLineWidth;
    _bottomLeftCorner.lineWidth = cropAreaCornerLineWidth;
    _bottomRightCorner.lineWidth = cropAreaCornerLineWidth;
    [self resetCropAreaByAspectRatio];
}

- (void)setCropAreaCornerWidth:(CGFloat)cropAreaCornerWidth
{
    _cropAreaCornerWidth = cropAreaCornerWidth;
    [self resetCornersOnSizeChanged];
}

- (void)setCropAreaCornerHeight:(CGFloat)cropAreaCornerHeight
{
    _cropAreaCornerHeight = cropAreaCornerHeight;
    [self resetCornersOnSizeChanged];
}

- (void)setCropAspectRatio:(CGFloat)cropAspectRatio
{
    _cropAspectRatio = MAX(cropAspectRatio, 0);
    [self resetCropAreaByAspectRatio];
}

- (void)setShowMidLines:(BOOL)showMidLines
{
    if(_cropAspectRatio == 0) {
        if(!_showMidLines && showMidLines) {
            [self createMidLines];
            [self resetMidLines];
        }
        else if(_showMidLines && !showMidLines) {
            [self removeMidLines];
        }
    }
    _showMidLines = showMidLines;
}

- (void)setShowCrossLines:(BOOL)showCrossLines
{
    _showCrossLines = showCrossLines;
    _cropAreaView.showCrossLines = _showCrossLines;
}

- (void)setCornerBorderInImage:(BOOL)cornerBorderInImage
{
    _cornerBorderInImage = cornerBorderInImage;
    [self resetCropAreaByAspectRatio];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame: frame];
    [self resetImageView];
}

- (void)setCenter:(CGPoint)center
{
    [super setCenter: center];
    [self resetImageView];
}

#pragma mark - KVO CallBack
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if([object isEqual: _cropAreaView]) {
        if(_showMidLines){
            [self resetMidLines];
        }
        [self resetCropTransparentArea];
        return;
    }
    if([object isEqual: _imageView]) {
        [self resetCropAreaByAspectRatio];
    }
}
#pragma Instance Methods
- (UIImage *)currentCroppedImage
{
    CGFloat scaleFactor = WIDTH(_imageView) / _cropImage.size.width;
    return [_cropImage imageAtRect: CGRectMake((MINX(_cropAreaView) + _cropAreaBorderLineWidth) / scaleFactor, (MINY(_cropAreaView) + _cropAreaBorderLineWidth) / scaleFactor, (WIDTH(_cropAreaView) - 2 * _cropAreaBorderLineWidth) / scaleFactor, (HEIGHT(_cropAreaView) - 2 * _cropAreaBorderLineWidth) / scaleFactor)];
}


- (void)dealloc
{
    [_cropAreaView removeObserver:self
                       forKeyPath:@"frame"];
    [_cropAreaView removeObserver:self
                       forKeyPath:@"center"];
    [_imageView removeObserver:self
                    forKeyPath:@"frame"];
}

@end
