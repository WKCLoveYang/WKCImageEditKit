//
//  UIImage+Blend.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/17.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKCBlendMode) {
    
    // 前后融合 推荐使用: WKCBlendModeMiddleSoft或者WKCBlendModeMiddle
    /** 前后融合,四周偏暗 */
    WKCBlendModeMiddleAroundDark = 0,
    /** 前后融合,四周很暗*/
    WKCBlendModeMiddleAroundPulsDark,
    /** 前后融合,颜色柔和, 更轻柔*/
    WKCBlendModeMiddleSoftLight,
    /** 前后融合,颜色柔和*/
    WKCBlendModeMiddleSoft,
    /** 前后融合*/
    WKCBlendModeMiddle,
    /** 前后融合,色彩加重*/
    WKCBlendModeMiddleColor,
    
    // 突出前景图 推荐使用: WKCBlendModeFront
    /** 突出前景*/
    WKCBlendModeFront,
    /** 突出前景更重*/
    WKCBlendModeFrontHard,
    /** 前景灰*/
    WKCBlendModeFrontGray,
    /** 前景变暗*/
    WKCBlendModeFrontLight,
    /** 前景变暗,稍柔和*/
    WKCBlendModeFrontSoftLight,
    
    // 突出背景图 推荐使用: WKCBlendModeBackground
    /** 突出背景, 背景正常*/
    WKCBlendModeBackground,
    /** 突出背景, 颜色很暗*/
    WKCBlendModeBackgroundDark,
    /** 突出背景, 颜色稍暗*/
    WKCBlendModeBackgroundLight
};

@interface UIImage (Blend)

- (UIImage *)imageWithFront:(UIImage *)front
                      alpha:(CGFloat)alpha
                  blendMode:(WKCBlendMode)mode;

@end
