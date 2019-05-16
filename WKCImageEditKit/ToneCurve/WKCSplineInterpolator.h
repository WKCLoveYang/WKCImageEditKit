//
//  WKCSplineInterpolator.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WKCSplineInterpolator : NSObject

- (id)initWithPoints:(NSArray *)points;
- (CIVector *)interpolatedPoint:(CGFloat)t;

@end
