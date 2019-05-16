//
//  WKCDrewContentView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCDrawContentView : UIView

// 画笔颜色
@property (nonatomic, strong) UIColor * lineColor;
// 画笔宽度
@property (nonatomic, assign) CGFloat lineWidth;

// 清屏
- (void)clear;
// 撤销
- (void)revoke;
// 擦除功能开启
- (void)erase;

@end

