//
//  WKCStickerGestureRecognizer.h
//  WKCStickerEditor
//
//  Created by WeiKunChao on 2019/4/15.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCStickerGestureRecognizer : UIGestureRecognizer

/** 比例 */
@property (nonatomic, assign) CGFloat scale;
/** 旋转角度 */
@property (nonatomic, assign) CGFloat rotation;

- (instancetype)initWithTarget:(id)target
                        action:(SEL)action
                    anchorView:(UIView *)anchorView;

- (void)reset;

@end
