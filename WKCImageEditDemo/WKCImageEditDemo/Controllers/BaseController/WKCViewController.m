//
//  ViewController.m
//  ffff
//
//  Created by 魏昆超 on 2018/9/20.
//  Copyright © 2018年 魏昆超. All rights reserved.
//

#import "WKCViewController.h"

@interface WKCViewController ()

@end

@implementation WKCViewController

- (BOOL)isNavigationHidden
{
    return NO;
}

- (BOOL)isInteractivePopGestureEabled
{
    return YES;
}

- (BOOL)isPopToRoot
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;

}

#pragma mark - Property
- (BOOL)isPushed
{
    return [self.navigationController.viewControllers containsObject:self];
}

@end
