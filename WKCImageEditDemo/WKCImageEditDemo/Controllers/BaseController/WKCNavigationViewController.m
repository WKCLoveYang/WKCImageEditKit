//
//  NavigationViewController.m
//  ffff
//
//  Created by 魏昆超 on 2019/1/9.
//  Copyright © 2019 魏昆超. All rights reserved.
//

#import "WKCNavigationViewController.h"

@interface WKCNavigationViewController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIBarButtonItem * leftBarItem;
@property (nonatomic, strong) id<UIGestureRecognizerDelegate> popGestureDelegate;
@property (nonatomic, strong) UIPanGestureRecognizer * popPanGesture;


@property (nonatomic, assign) BOOL isToRoot;
@property (nonatomic, assign) BOOL isInteractiveEnable;
@property (nonatomic, assign) BOOL isShouldHidden;

@end

@implementation WKCNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.delegate = self;
    [self.navigationBar setTranslucent:NO];
    [self setNeedsFocusUpdate];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = self.leftBarItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)actionBack
{
    if (self.isToRoot) {
        [self popToRootViewControllerAnimated:YES];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.isNavigationBarHidden != self.isShouldHidden) {
        [self setNavigationBarHidden:self.isShouldHidden animated:YES];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isRoot = viewController == navigationController.viewControllers.firstObject;
    if (self.isInteractiveEnable) {
        if (isRoot) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
            if (self.isToRoot) {
                for (UIViewController * vc in self.viewControllers) {
                    if (![vc isKindOfClass:navigationController.viewControllers.firstObject.class] && ![vc isKindOfClass:viewController.class]) {
                        [vc removeFromParentViewController];
                    }
                }
            }
            self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
            [self.interactivePopGestureRecognizer setEnabled:NO];
        }
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        [self.interactivePopGestureRecognizer setEnabled:!isRoot];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Propertys
- (UIBarButtonItem *)leftBarItem
{
    if (!_leftBarItem) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 44, 44);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 16);
        [button addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
        _leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _leftBarItem;
}

- (id<UIGestureRecognizerDelegate>)popGestureDelegate
{
    if (!_popGestureDelegate) {
        _popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    }
    return _popGestureDelegate;
}

- (UIPanGestureRecognizer *)popPanGesture
{
    if (!_popPanGesture) {
        SEL sel = NSSelectorFromString(@"handleNavigationTransition:");
        _popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:_popGestureDelegate action:sel];
        _popPanGesture.maximumNumberOfTouches = 1;
    }
    return _popPanGesture;
}

- (BOOL)isToRoot
{
    return ([self.topViewController respondsToSelector:@selector(isPopToRoot)] && [(id<WKCNavigationControllerProtocol>)self.topViewController isPopToRoot]) ? YES : NO;
}

- (BOOL)isShouldHidden
{
    return ([self.topViewController respondsToSelector:@selector(isNavigationHidden)] && [(id<WKCNavigationControllerProtocol>)self.topViewController isNavigationHidden]) ? YES : NO;
}

- (BOOL)isInteractiveEnable
{
    return ([self.topViewController respondsToSelector:@selector(isInteractivePopGestureEabled)] && [(id<WKCNavigationControllerProtocol>)self.topViewController isInteractivePopGestureEabled]) ? YES : NO;
}

@end
