//
//  WKCTextEditor.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKCTextEditor;

@protocol WKCTextEditorDelegate <NSObject>

@optional;

// 点击content
- (void)textEditorDidTapContentView:(WKCTextEditor *)textEditor;
// 点击删除
- (void)textEditorDidTapDeleteControl:(WKCTextEditor *)textEditor;
// 点击左下角的
- (void)textEditorDidTapLeftBottomControl:(WKCTextEditor *)textEditor;
// 点击右上角的
- (void)textEditorDidTapRightTopControl:(WKCTextEditor *)textEditor;

// 右下角的是旋转方法, 功能固定.不回调

@end


@interface WKCTextEditor : UIView

@property (nonatomic, weak) id<WKCTextEditorDelegate> delegate;

/** 控件是否处于活跃状态 默认YES*/
@property (nonatomic, assign) BOOL isControlActivity;
/** 边框是否处于活跃状态 默认YES*/
@property (nonatomic, assign) BOOL isBorderActivity;
/** 选中时是是否要动画 默认YES*/
@property (nonatomic, assign) BOOL shouldAnimation;

/** 内容*/
@property (nonatomic, strong) NSAttributedString * contentString;
/** 宽度限制*/
@property (nonatomic, assign) CGFloat textLimitWidth;
/** 旋转视图*/
@property (nonatomic, strong) UIImage * rorationImage;
/** 删除视图*/
@property (nonatomic, strong) UIImage * deleteImage;
/** 左下角视图*/
@property (nonatomic, strong) UIImage * leftBottomImage;
/** 右上角视图*/
@property (nonatomic, strong) UIImage * rightTopImage;

/** 边框是否连续*/
@property (nonatomic, assign) BOOL isBorderContinue;
/** 边框宽度*/
@property (nonatomic, assign) CGFloat borderWidth;
/** 边框颜色*/
@property (nonatomic, strong) UIColor * borderColor;

/** 最小比例, 默认0.5*/
@property (nonatomic, assign) CGFloat minScale;
/** 最大比例, 默认2.0*/
@property (nonatomic, assign) CGFloat maxScale;

- (instancetype)initWithContentFrame:(CGRect)frame
                         controlSize:(CGSize)size;
// 辞退键盘
- (void)resignKeyboard;

@end

