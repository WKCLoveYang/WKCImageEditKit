//
//  UIImage+OrienHandle.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OrienHandle)

- (UIImage *)fixOrientation;
- (UIImage *)imageAtRect:(CGRect)rect;

@end
