//
//  WKCTextItemView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCTextEditor.h"

@class WKCTextItemView;

@protocol WKCTextItemViewDataSource <NSObject>

@optional;
// Roration图标
- (UIImage *)textViewRorationImage:(WKCTextItemView *)textView;
// Delete图标
- (UIImage *)textViewDeleteImage:(WKCTextItemView *)textView;
// 左下角图标
- (UIImage *)textViewLeftBottomImage:(WKCTextItemView *)textView;
// 右上角图标
- (UIImage *)textViewRightTopImage:(WKCTextItemView *)textView;


@end

@interface WKCTextItemView : WKCTextEditor

@property (nonatomic, weak) id<WKCTextItemViewDataSource> dataSource;
// 是否活跃
@property (nonatomic, assign) BOOL shouldActivity;

@end
