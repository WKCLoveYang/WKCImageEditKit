//
//  WKCStickerView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKCStickerView;

@protocol WKCStickerViewDelegate <NSObject>

@optional;
// 到达数量界限
- (void)stickerViewDidReachLimit:(WKCStickerView *)stickerView;
// 点击了左下角
- (void)stickerViewDidTapLeftBottom:(WKCStickerView *)stickerView;
// 点击了右上角
- (void)stickerViewDidTapRightTop:(WKCStickerView *)stickerView;

@end



@interface WKCStickerView : UIView

@property (nonatomic, weak) id<WKCStickerViewDelegate> delegate;

// 背景图
@property (nonatomic, strong) UIImage * contentImage;
// 背景视图
@property (nonatomic, strong, readonly) UIImageView * contentImageView;

#pragma mark - 贴图
// 贴图
@property (nonatomic, strong) UIImage * stickerImage;
/** 旋转视图*/
@property (nonatomic, strong) UIImage * stickerRorationImage;
/** 删除视图*/
@property (nonatomic, strong) UIImage * stickerDeleteImage;
/** 左下角视图*/
@property (nonatomic, strong) UIImage * stickerLeftBottomImage;
/** 右上角视图*/
@property (nonatomic, strong) UIImage * stickerRightTopImage;
/** 边框是否连续*/
@property (nonatomic, assign) BOOL stickerIsBorderContinue;
/** 边框宽度*/
@property (nonatomic, assign) CGFloat stickerBorderWidth;
/** 边框颜色*/
@property (nonatomic, strong) UIColor * stickerBorderColor;
/** 最小比例, 默认0.5*/
@property (nonatomic, assign) CGFloat stickerMinScale;
/** 最大比例, 默认2.0*/
@property (nonatomic, assign) CGFloat stickerMaxScale;
/** 最多可以有几个贴纸, 默认5*/
@property (nonatomic, assign) NSInteger stickerLimitCount;

// 当前视图
@property (nonatomic, strong, readonly) UIImage * currentImage;

@end
