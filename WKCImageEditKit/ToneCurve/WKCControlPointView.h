//
//  WKCControlPointView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCControlPointView : UIView

@property (nonatomic, strong) CIVector * controlPoint;
@property (nonatomic, strong) UIColor * bgColor;
@property (nonatomic, assign) CGRect layoutFrame;

@end
