//
//  WKCTextGestureRecognizer.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WKCTextGestureRecognizer : UIGestureRecognizer

/** 比例 */
@property (nonatomic, assign) CGFloat scale;
/** 旋转角度 */
@property (nonatomic, assign) CGFloat rotation;

- (instancetype)initWithTarget:(id)target
                        action:(SEL)action
                    anchorView:(UIView *)anchorView;

- (void)reset;

@end

