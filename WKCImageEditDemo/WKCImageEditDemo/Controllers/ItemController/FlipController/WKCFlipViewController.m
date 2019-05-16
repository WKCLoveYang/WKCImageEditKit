//
//  WKCFlipViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCFlipViewController.h"
#import <Masonry.h>
#import "UIColor+Common.h"
#import <UIImage+Flip.h>

@interface WKCFlipViewController ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIButton * rorationButton;
@property (nonatomic, strong) UIButton * flipButton;
@property (nonatomic, strong) UIButton * degreeButton;

@end

@implementation WKCFlipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Flip";
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.rorationButton];
    [self.view addSubview:self.flipButton];
    [self.view addSubview:self.degreeButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_width);
    }];
    [self.rorationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(30);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.flipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.degreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    if (sender == _rorationButton)
    {
        self.imageView.image = [self.imageView.image flipHorizontal];
    }
    else if (sender == _flipButton)
    {
       self.imageView.image = [self.imageView.image flipVertical];
    }
    else if (sender == _degreeButton)
    {
       self.imageView.image = [self.imageView.image imageRotatedByDegrees:90];
    }
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _imageView;
}

- (UIButton *)rorationButton
{
    if (!_rorationButton)
    {
        _rorationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rorationButton setTitle:@"水平" forState:UIControlStateNormal];
        [_rorationButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _rorationButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _rorationButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _rorationButton.layer.cornerRadius = 12;
        _rorationButton.layer.masksToBounds = YES;
        [_rorationButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rorationButton;
}

- (UIButton *)flipButton
{
    if (!_flipButton)
    {
        _flipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flipButton setTitle:@"垂直" forState:UIControlStateNormal];
        [_flipButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _flipButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _flipButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _flipButton.layer.cornerRadius = 12;
        _flipButton.layer.masksToBounds = YES;
        [_flipButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _flipButton;
}

- (UIButton *)degreeButton
{
    if (!_degreeButton)
    {
        _degreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_degreeButton setTitle:@"角度" forState:UIControlStateNormal];
        [_degreeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _degreeButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _degreeButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _degreeButton.layer.cornerRadius = 12;
        _degreeButton.layer.masksToBounds = YES;
        [_degreeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _degreeButton;
}

@end
