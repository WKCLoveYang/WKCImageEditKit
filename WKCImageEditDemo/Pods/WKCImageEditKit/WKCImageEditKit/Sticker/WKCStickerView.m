//
//  WKCStickerView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCStickerView.h"
#import "WKCStickerItemView.h"

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



@interface WKCStickerView()
<WKCStcikerEditorDelegate,
WKCStickerItemViewDataSource>
{
    CGFloat _stickerWidth;
    CGFloat _stickerHeight;
    NSInteger _stickerCount;
}

@property (nonatomic, strong) UIImageView * contentImageView;
@property (nonatomic, strong) WKCStickerItemView * currentStickerItem;

@end

@implementation WKCStickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _stickerWidth = frame.size.width / 2.0;
        _stickerHeight = frame.size.height / 2.0;
        _stickerCount = 0;
        _stickerLimitCount = 5;
        _stickerIsBorderContinue = NO;
        _stickerBorderWidth = 2;
        _stickerBorderColor = UIColor.whiteColor;
        _stickerMinScale = 0.5;
        _stickerMaxScale = 2;
        [self addSubview:self.contentImageView];
    }
    
    return self;
}

- (void)setContentImage:(UIImage *)contentImage
{
    _contentImage = contentImage;
    self.contentImageView.image = contentImage;
    
    CGFloat imageWidth = contentImage.size.width;
    CGFloat imageHeight = contentImage.size.height;
    
    CGFloat drawWidth = CGRectGetWidth(self.frame);
    CGFloat drawHeight = CGRectGetHeight(self.frame);
    
    if (drawHeight / drawWidth < imageHeight / imageWidth) // 等高
    {
        self.contentImageView.bounds = CGRectMake(0, 0, drawHeight * imageWidth / imageHeight, drawHeight);
        self.contentImageView.center = self.center;
    }
    else // 等宽
    {
        self.contentImageView.bounds = CGRectMake(0, 0, drawWidth, drawWidth * imageHeight / imageWidth);
        self.contentImageView.center = self.center;
    }
    
    self.currentStickerItem.center = CGPointMake(self.contentImageView.bounds.size.width / 2.0, self.contentImageView.bounds.size.height / 2.0);
}

- (void)setStickerImage:(UIImage *)stickerImage
{
    _stickerImage = stickerImage;
    
    if (_stickerCount >= self.stickerLimitCount)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(stickerViewDidReachLimit:)])
        {
            [self.delegate stickerViewDidReachLimit:self];
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

- (UIImage *)currentImage
{
    // 取消所有贴图的选中状态
    for (UIView * view in _contentImageView.subviews)
    {
        if ([view isKindOfClass:WKCStickerItemView.class])
        {
            WKCStickerItemView * sticker = (WKCStickerItemView *)view;
            sticker.shouldActivity = NO;
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


#pragma mark -🌹WKCStickerItemViewDataSource
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

#pragma mark -✨WKCStcikerEditorDelegate
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(stickerViewDidTapLeftBottom:)])
    {
        [self.delegate stickerViewDidTapLeftBottom:self];
    }
}

- (void)stickerEditorDidTapRightTopControl:(WKCStcikerEditor *)stcikerEditor
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(stickerViewDidTapRightTop:)])
    {
        [self.delegate stickerViewDidTapRightTop:self];
    }
}

#pragma mark -🌲Property
- (UIImageView *)contentImageView
{
    if (!_contentImageView)
    {
        _contentImageView = [[UIImageView alloc] initWithFrame:self.bounds];
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
    for (UIView * sub in _contentImageView.subviews)
    {
        if ([sub isKindOfClass:WKCStickerItemView.class])
        {
            WKCStickerItemView * item = (WKCStickerItemView *)sub;
            item.shouldActivity = NO;
        }
    }
}

@end
