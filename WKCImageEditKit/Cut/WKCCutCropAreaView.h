//
//  WKCCutCropAreaView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WKCCutCropAreaView : UIView

@property (nonatomic, assign) CGFloat crossLineWidth;
@property (nonatomic, strong) UIColor * crossLineColor;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) BOOL showCrossLines;

@end

