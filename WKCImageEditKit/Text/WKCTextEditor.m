//
//  WKCTextEditor.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCTextEditor.h"
#import "WKCTextGestureRecognizer.h"

@interface WKCTextEditor()
<UIGestureRecognizerDelegate,
UITextViewDelegate>
{
    CGSize _controlSize;
}

@property (nonatomic, strong) UITextView * content;
@property (nonatomic, strong) UIImageView * deleteControl;
@property (nonatomic, strong) UIImageView * resizeControl;
@property (nonatomic, strong) UIImageView * leftBottomControl;
@property (nonatomic, strong) UIImageView * rightTopControl;

@property (nonatomic, strong) CAShapeLayer * shapeLayer;

@end

@implementation WKCTextEditor

- (instancetype)initWithContentFrame:(CGRect)frame
                         controlSize:(CGSize)size
{
    self = [super initWithFrame:CGRectMake(frame.origin.x - size.width / 2.0,
                                           frame.origin.y - size.height / 2.0,
                                           frame.size.width + size.width,
                                           frame.size.width + size.height)];
    
    if (self)
    {
        _controlSize = size;
        
        [self wkc_setupConfign];
        [self wkc_initPropertyWithFrame:frame];
        [self wkc_setupSubviews];
        [self wkc_initShapeLayer];
        [self wkc_addGesture];
 
    }
    return self;
}

- (void)resignKeyboard
{
    [self.content resignFirstResponder];
}

- (void)setContentString:(NSAttributedString *)contentString
{
    _contentString = contentString;
    
    _content.attributedText = contentString;
}

- (void)setBounds:(CGRect)bounds
{
    _content.frame = CGRectMake(_controlSize.width / 2.0, _controlSize.height / 2.0, bounds.size.width, bounds.size.height);
    _resizeControl.frame = CGRectMake(CGRectGetMaxX(_content.frame) - _controlSize.width / 2.0, CGRectGetMaxY(_content.frame) - _controlSize.height / 2.0, _controlSize.width, _controlSize.height);
    _deleteControl.frame = CGRectMake(0, 0, _controlSize.width, _controlSize.height);
    _rightTopControl.frame = CGRectMake(CGRectGetMaxX(_content.frame) - _controlSize.width / 2.0, 0, _controlSize.width, _controlSize.height);
    _leftBottomControl.frame = CGRectMake(0, CGRectGetMaxY(_content.frame) - _controlSize.height / 2.0, _controlSize.width, _controlSize.height);
    _shapeLayer.bounds = _content.frame;
    _shapeLayer.position = CGPointMake(_content.frame.size.width / 2.0, _content.frame.size.height / 2.0);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _content.frame);
    [_shapeLayer setPath:path];
    CGPathRelease(path);
}

#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSRange range = NSMakeRange(0, textView.text.length);
    NSDictionary * dic = [_contentString attributesAtIndex:0 effectiveRange:&range];
    
    CGFloat currentWidth = [textView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 50) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    
    CGFloat width = 0, height = 0;
    
    if (currentWidth < _textLimitWidth)
    {
        width = currentWidth + 20;
        height = 50;
    }
    else
    {
        CGFloat currentHeight = [textView.text boundingRectWithSize:CGSizeMake(_textLimitWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
        width = _textLimitWidth;
        height = currentHeight + 20;
    }
    
    self.bounds = CGRectMake(0, 0, width, height);
}

- (void)wkc_initPropertyWithFrame:(CGRect)frame
{
    _content = [[UITextView alloc] initWithFrame:CGRectMake(_controlSize.width / 2.0, _controlSize.height / 2.0, frame.size.width, frame.size.height)];
    _content.backgroundColor = [UIColor clearColor];
    _content.textColor = UIColor.blackColor;
    _content.font = [UIFont boldSystemFontOfSize:18];
    _content.showsVerticalScrollIndicator = NO;
    _content.showsHorizontalScrollIndicator = NO;
    _content.scrollEnabled = NO;
    _content.textAlignment = NSTextAlignmentCenter;
    _content.layer.masksToBounds = YES;
    _content.delegate = self;
    
    _resizeControl = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_content.frame) - _controlSize.width / 2.0, CGRectGetMaxY(_content.frame) - _controlSize.height / 2.0, _controlSize.width, _controlSize.height)];
    _resizeControl.contentMode = UIViewContentModeScaleAspectFit;
    
    _deleteControl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _controlSize.width, _controlSize.height)];
    _deleteControl.contentMode = UIViewContentModeScaleAspectFit;
    
    _rightTopControl = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_content.frame) - _controlSize.width / 2.0, 0, _controlSize.width, _controlSize.height)];
    _rightTopControl.contentMode = UIViewContentModeScaleAspectFit;
    
    _leftBottomControl = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_content.frame) - _controlSize.height / 2.0, _controlSize.width, _controlSize.height)];
    _leftBottomControl.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)wkc_setupSubviews
{
    [self addSubview:_content];
    [self addSubview:_resizeControl];
    [self addSubview:_deleteControl];
    [self addSubview:_leftBottomControl];
    [self addSubview:_rightTopControl];
}

- (void)wkc_initShapeLayer
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.bounds = _content.frame;
    _shapeLayer.position = CGPointMake(_content.frame.size.width / 2.0, _content.frame.size.height / 2.0);
    _shapeLayer.fillColor = UIColor.clearColor.CGColor;
    _shapeLayer.lineJoin = kCALineJoinRound;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _content.frame);
    [_shapeLayer setPath:path];
    CGPathRelease(path);
}

- (void)wkc_setupConfign
{
    self.exclusiveTouch = YES;
    self.userInteractionEnabled = YES;
    self.resizeControl.userInteractionEnabled = YES;
    self.deleteControl.userInteractionEnabled = YES;
    self.rightTopControl.userInteractionEnabled = YES;
    self.leftBottomControl.userInteractionEnabled = YES;
    
    self.isBorderActivity = YES;
    self.isControlActivity = YES;
    self.shouldAnimation = YES;
    
    _minScale = 0.5;
    _maxScale = 2.0;
}

- (void)wkc_addGesture
{
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    rotateGesture.delegate = self;
    
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleScale:)];
    pinGesture.delegate = self;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    panGesture.delegate = self;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    
    WKCTextGestureRecognizer * stickerGesture = [[WKCTextGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleHandAction:) anchorView:_content];
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer2.numberOfTapsRequired = 1;
    tapRecognizer2.delegate = self;
    
    UITapGestureRecognizer *tapRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer3.numberOfTapsRequired = 1;
    tapRecognizer3.delegate = self;
    
    UITapGestureRecognizer *tapRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer4.numberOfTapsRequired = 1;
    tapRecognizer4.delegate = self;
    
    [_content addGestureRecognizer:rotateGesture];
    [_content addGestureRecognizer:pinGesture];
    [_content addGestureRecognizer:panGesture];
    [_content addGestureRecognizer:tapRecognizer];
    [_resizeControl addGestureRecognizer:stickerGesture];
    [_deleteControl addGestureRecognizer:tapRecognizer2];
    [_rightTopControl addGestureRecognizer:tapRecognizer3];
    [_leftBottomControl addGestureRecognizer:tapRecognizer4];
}

- (void)wkc_handleTapContentView
{
    [self.superview bringSubviewToFront:self];
    
    if (_shouldAnimation)
    {
        [self wkc_performShakeAnimation:self];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(textEditorDidTapContentView:)])
    {
        [_delegate textEditorDidTapContentView:self];
        [_content becomeFirstResponder];
    }
    
    self.isControlActivity = YES;
    self.isBorderActivity = YES;
}

- (void)wkc_performShakeAnimation:(UIView *)targetView
{
    [targetView.layer removeAnimationForKey:@"anim"];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5f;
    animation.values = @[[NSValue valueWithCATransform3D:targetView.layer.transform],
                         [NSValue valueWithCATransform3D:CATransform3DScale(targetView.layer.transform, 1.05, 1.05, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(targetView.layer.transform, 0.95, 0.95, 1.0)],
                         [NSValue valueWithCATransform3D:targetView.layer.transform]
                         ];
    animation.removedOnCompletion = YES;
    [targetView.layer addAnimation:animation forKey:@"anim"];
}

- (void)wkc_relocalControlView
{
    CGPoint originalCenter = CGPointApplyAffineTransform(_content.center, CGAffineTransformInvert(_content.transform));
    
    CGFloat maxX = originalCenter.x + _content.bounds.size.width / 2.0;
    CGFloat maxY = originalCenter.y + _content.bounds.size.height / 2.0;
    CGFloat minX = originalCenter.x - _content.bounds.size.width / 2.0;
    CGFloat minY = originalCenter.y - _content.bounds.size.height / 2.0;
    
    _resizeControl.center = CGPointApplyAffineTransform(CGPointMake(maxX, maxY), _content.transform);
    _deleteControl.center = CGPointApplyAffineTransform(CGPointMake(minX, minY), _content.transform);
    _rightTopControl.center = CGPointApplyAffineTransform(CGPointMake(maxX, minY), _content.transform);
    _leftBottomControl.center = CGPointApplyAffineTransform(CGPointMake(minX, maxY), _content.transform);
}

- (void)wkc_scaleLimit:(CGFloat)scale
{
    CGFloat currentScale = [[_content.layer valueForKeyPath:@"transform.scale"] floatValue];
    
    if (scale * currentScale <= _minScale)
    {
        scale = _minScale / currentScale;
    }
    else if (scale * currentScale >= _maxScale)
    {
        scale = _maxScale / currentScale;
    }
}

#pragma mark - Gesture
- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.view == _content)
    {
        [self wkc_handleTapContentView];
    }
    else if (gesture.view == _deleteControl)
    {
        [self removeFromSuperview];
        
        if (_delegate && [_delegate respondsToSelector:@selector(textEditorDidTapDeleteControl:)])
        {
            [_delegate textEditorDidTapDeleteControl:self];
        }
    }
    else if (gesture.view == _rightTopControl)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(textEditorDidTapRightTopControl:)])
        {
            [_delegate textEditorDidTapRightTopControl:self];
        }
    }
    else if (gesture.view == _leftBottomControl)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(textEditorDidTapLeftBottomControl:)])
        {
            [_delegate textEditorDidTapLeftBottomControl:self];
        }
    }
}

- (void)handleMove:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:[self superview]];
    
    CGPoint targetPoint = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    targetPoint.x = MAX(0, targetPoint.x);
    targetPoint.y = MAX(0, targetPoint.y);
    targetPoint.x = MIN(self.superview.bounds.size.width, targetPoint.x);
    targetPoint.y = MIN(self.superview.bounds.size.height, targetPoint.y);
    
    [self setCenter:targetPoint];
    [gesture setTranslation:CGPointZero inView:[self superview]];
}

- (void)handleScale:(UIPinchGestureRecognizer *)gesture
{
    [self wkc_scaleLimit:gesture.scale];
    
    _content.transform = CGAffineTransformScale(_content.transform, gesture.scale, gesture.scale);
    gesture.scale = 1;
    
    [self wkc_relocalControlView];
}

- (void)handleRotate:(UIRotationGestureRecognizer *)gesture
{
    _content.transform = CGAffineTransformRotate(_content.transform, gesture.rotation);
    gesture.rotation = 0;
    
    [self wkc_relocalControlView];
}

- (void)handleSingleHandAction:(WKCTextGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        self.isControlActivity = NO;
    }
    else if ((gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateFailed) || (gesture.state == UIGestureRecognizerStateCancelled))
    {
        self.isControlActivity = YES;
    }
    
    [self wkc_scaleLimit:gesture.scale];
    
    _content.transform = CGAffineTransformScale(_content.transform, gesture.scale, gesture.scale);
    _content.transform = CGAffineTransformRotate(_content.transform, gesture.rotation);
    [gesture reset];
    
    [self wkc_relocalControlView];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) ? NO : YES;
}


#pragma mark - HitTest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden || !self.userInteractionEnabled || self.alpha < 0.01)
    {
        return nil;
    }
    
    if (_isControlActivity)
    {
        if ([_resizeControl pointInside:[self convertPoint:point toView:_resizeControl] withEvent:event])
        {
            return _resizeControl;
        }
        
        if ([_deleteControl pointInside:[self convertPoint:point toView:_deleteControl] withEvent:event])
        {
            return _deleteControl;
        }
        
        if ([_rightTopControl pointInside:[self convertPoint:point toView:_rightTopControl] withEvent:event])
        {
            return _rightTopControl;
        }
        
        if ([_leftBottomControl pointInside:[self convertPoint:point toView:_leftBottomControl] withEvent:event])
        {
            return _leftBottomControl;
        }
    }
    
    if ([_content pointInside:[self convertPoint:point toView:_content] withEvent:event])
    {
        return _content;
    }
    
    return nil;
}

#pragma mark -Setter

- (void)setRorationImage:(UIImage *)rorationImage
{
    _rorationImage = rorationImage;
    _resizeControl.image = rorationImage;
}

- (void)setDeleteImage:(UIImage *)deleteImage
{
    _deleteImage = deleteImage;
    _deleteControl.image = deleteImage;
}

- (void)setLeftBottomImage:(UIImage *)leftBottomImage
{
    _leftBottomImage = leftBottomImage;
    _leftBottomControl.image = leftBottomImage;
}

- (void)setRightTopImage:(UIImage *)rightTopImage
{
    _rightTopImage = rightTopImage;
    _rightTopControl.image = rightTopImage;
}

- (void)setIsBorderContinue:(BOOL)isBorderContinue
{
    _isBorderContinue = isBorderContinue;
    if (!isBorderContinue)
    {
        _shapeLayer.allowsEdgeAntialiasing = YES;
        _shapeLayer.lineDashPattern = @[@(5),@(3)];
    }
    else
    {
        _shapeLayer.allowsEdgeAntialiasing = NO;
        _shapeLayer.lineDashPattern = nil;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _shapeLayer.strokeColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    _shapeLayer.lineWidth = borderWidth;
}

- (void)setIsControlActivity:(BOOL)isControlActivity
{
    _isControlActivity = isControlActivity;
    
    _deleteControl.hidden = !_isControlActivity;
    _resizeControl.hidden = !_isControlActivity;
    _rightTopControl.hidden = !_isControlActivity;
    _leftBottomControl.hidden = !_isControlActivity;
}

- (void)setIsBorderActivity:(BOOL)isBorderActivity
{
    _isBorderActivity = isBorderActivity;
    
    if (isBorderActivity)
    {
        [_content.layer addSublayer:_shapeLayer];
    }
    else
    {
        [_shapeLayer removeFromSuperlayer];
    }
}

@end
