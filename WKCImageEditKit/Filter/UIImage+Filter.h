//
//  UIImage+Filter.h
//  ddasd
//
//  Created by WeiKunChao on 2019/5/13.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIImageFilterType) {
    UIImageFilterTypeCurve,
    UIImageFilterTypeChrome,
    UIImageFilterTypeFade,
    UIImageFilterTypeInstant,
    UIImageFilterTypeMono,
    UIImageFilterTypeProcess,
    UIImageFilterTypeTonal,
    UIImageFilterTypeTransfer
};

@interface UIImage (Filter)

- (UIImage *)filterWithType:(UIImageFilterType)type;

@end
