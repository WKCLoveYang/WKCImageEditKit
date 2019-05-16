//
//  WKCStickerItemView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCStcikerEditor.h"

@class WKCStickerItemView;

@protocol WKCStickerItemViewDataSource <NSObject>

@optional;
// Roration图标
- (UIImage *)stickerViewRorationImage:(WKCStickerItemView *)stickerView;
// Delete图标
- (UIImage *)stickerViewDeleteImage:(WKCStickerItemView *)stickerView;
// 左下角图标
- (UIImage *)stickerViewLeftBottomImage:(WKCStickerItemView *)stickerView;
// 右上角图标
- (UIImage *)stickerViewRightTopImage:(WKCStickerItemView *)stickerView;

@end


@interface WKCStickerItemView : WKCStcikerEditor

@property (nonatomic, weak) id<WKCStickerItemViewDataSource> dataSource;
// 是否活跃
@property (nonatomic, assign) BOOL shouldActivity;

- (instancetype)initWithContentFrame:(CGRect)frame contentImage:(UIImage *)image;

@end

