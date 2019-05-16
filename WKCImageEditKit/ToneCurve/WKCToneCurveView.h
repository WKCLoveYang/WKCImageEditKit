//
//  WKCToneCurveView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKCToneCurveView;

@protocol WKCToneCurveViewDelegate <NSObject>

- (UIImage *)toneCurveViewOriginImage:(WKCToneCurveView *)toneCurveView;
- (void)toneCurveView:(WKCToneCurveView *)toneCurveView didtoneCurved:(UIImage *)newImage;

@end


@interface WKCToneCurveView : UIView

// 代理
@property (nonatomic, weak) id<WKCToneCurveViewDelegate> delegate;
// 网格颜色, 默认黑色
@property (nonatomic, strong) UIColor * gridColor;
// 网格宽度, 默认1
@property (nonatomic, assign) CGFloat gridWidth;
// 点颜色, 默认黑色
@property (nonatomic, strong) UIColor * pointColor;
// 线框颜色
@property (nonatomic, strong) UIColor * lineColor;
// 线框宽度
@property (nonatomic, assign) CGFloat lineWidth;

// 初始化坐标和点大小
- (instancetype)initWithFrame:(CGRect)frame pointSize:(CGSize)pointSize;
// 重置点
- (void)resetPoints;

@end
