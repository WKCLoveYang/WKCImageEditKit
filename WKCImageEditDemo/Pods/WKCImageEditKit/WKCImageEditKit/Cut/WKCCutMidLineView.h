//
//  WKCCutMidLineView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MID_LINE_INTERACT_WIDTH 44
#define MID_LINE_INTERACT_HEIGHT 44

typedef NS_ENUM(NSInteger, WKCMidLineType) {
    WKCMidLineTypeTop,
    WKCMidLineTypeBottom,
    WKCMidLineTypeLeft,
    WKCMidLineTypeRight
};

@interface WKCCutMidLineView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) UIColor * lineColor;
@property (nonatomic, assign) WKCMidLineType type;


- (instancetype)initWithLineWidth:(CGFloat)lineWidth
                       lineHeight:(CGFloat)lineHeight
                        lineColor:(UIColor *)lineColor;

@end
