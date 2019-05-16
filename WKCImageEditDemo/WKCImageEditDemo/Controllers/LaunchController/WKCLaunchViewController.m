//
//  WKCLaunchViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCLaunchViewController.h"
#import "WKCNavigationViewController.h"
#import "WKCHomeViewController.h"
#import "WKCAppDelegate.h"

@interface WKCLaunchViewController ()

@end

@implementation WKCLaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        WKCNavigationViewController * naVc = [[WKCNavigationViewController alloc] initWithRootViewController:[[WKCHomeViewController alloc] init]];
        WKCAppDelegate.shared.window.rootViewController = naVc;
    });
}



@end
