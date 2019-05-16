//
//  ViewController.h
//  ffff
//
//  Created by 魏昆超 on 2018/9/20.
//  Copyright © 2018年 魏昆超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCNavigationControllerProtocol.h"

@interface WKCViewController : UIViewController<WKCNavigationControllerProtocol>

@property (nonatomic, assign, readonly) BOOL isPushed;

@end

