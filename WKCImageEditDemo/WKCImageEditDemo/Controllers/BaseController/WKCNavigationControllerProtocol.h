//
//  NavigationControllerProtocol.h
//  ffff
//
//  Created by 魏昆超 on 2019/1/9.
//  Copyright © 2019 魏昆超. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WKCNavigationControllerProtocol <NSObject>

@optional

/**
 是否应该隐藏导航栏

 @return 布尔值
 */
- (BOOL)isNavigationHidden;

/**
 是否要返回根控制器

 @return 布尔值
 */
- (BOOL)isPopToRoot;

/**
 侧滑手势是否有效

 @return 布尔值
 */
- (BOOL)isInteractivePopGestureEabled;

@end
