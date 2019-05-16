//
//  WKCCutCornerView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH(_view) CGRectGetWidth(_view.bounds)
#define HEIGHT(_view) CGRectGetHeight(_view.bounds)
#define MAXX(_view) CGRectGetMaxX(_view.frame)
#define MAXY(_view) CGRectGetMaxY(_view.frame)
#define MINX(_view) CGRectGetMinX(_view.frame)
#define MINY(_view) CGRectGetMinY(_view.frame)

// 位置
typedef NS_ENUM(NSInteger, WKCCropAreaCornerPosition) {
    WKCCropAreaCornerPositionTopLeft,
    WKCCropAreaCornerPositionTopRight,
    WKCCropAreaCornerPositionBottomLeft,
    WKCCropAreaCornerPositionBottomRight
};

@interface WKCCutCornerView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * lineColor;
@property (nonatomic, strong) WKCCutCornerView * relativeViewX;
@property (nonatomic, strong) WKCCutCornerView * relativeViewY;
@property (nonatomic, assign) WKCCropAreaCornerPosition cornerPosition;

- (instancetype)initWithFrame:(CGRect)frame
                    lineColor:(UIColor *)lineColor
                    lineWidth:(CGFloat)lineWidth;

- (void)updateSizeWithWidth:(CGFloat)width
                     height:(CGFloat)height;

@end

