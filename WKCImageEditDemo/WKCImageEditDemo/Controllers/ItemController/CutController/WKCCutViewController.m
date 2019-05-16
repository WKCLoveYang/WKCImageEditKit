//
//  WKCCutViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCCutViewController.h"
#import <WKCCutView.h>
#import <Masonry.h>
#import "UIColor+Common.h"

@interface WKCCutViewController ()

@property (nonatomic, strong) WKCCutView * cutView;
@property (nonatomic, strong) UIButton * saveButton;
@property (nonatomic, strong) UIImageView * presentImageView;

@end

@implementation WKCCutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Cut";

    [self.view addSubview:self.cutView];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.presentImageView];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.presentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.saveButton.mas_top).offset(-15);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    self.presentImageView.image = self.cutView.currentCroppedImage;
}

- (WKCCutView *)cutView
{
    if (!_cutView)
    {
        _cutView = [[WKCCutView alloc] initWithFrame:CGRectMake(0, 20, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width)];
        _cutView.cropImage = [UIImage imageNamed:@"bg"];
        _cutView.showMidLines = YES;
        _cutView.needScaleCrop = YES;
        _cutView.showCrossLines = YES;
        _cutView.cornerBorderInImage = NO;
        _cutView.cropAreaCornerWidth = 44;
        _cutView.cropAreaCornerHeight = 44;
        _cutView.minSpace = 30;
        _cutView.cropAreaCornerLineColor = [UIColor whiteColor];
        _cutView.cropAreaBorderLineColor = [UIColor whiteColor];
        _cutView.cropAreaCornerLineWidth = 6;
        _cutView.cropAreaBorderLineWidth = 4;
        _cutView.cropAreaMidLineWidth = 20;
        _cutView.cropAreaMidLineHeight = 6;
        _cutView.cropAreaMidLineColor = [UIColor whiteColor];
        _cutView.cropAreaCrossLineColor = [UIColor whiteColor];
        _cutView.cropAreaCrossLineWidth = 4;
        _cutView.initialScaleFactor = .8f;
        _cutView.cropAspectRatio = 1;
    }
    
    return _cutView;
}

- (UIButton *)saveButton
{
    if (!_saveButton)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _saveButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _saveButton.layer.cornerRadius = 12;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _saveButton;
}

- (UIImageView *)presentImageView
{
    if (!_presentImageView)
    {
        _presentImageView = [[UIImageView alloc] init];
        _presentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _presentImageView;
}

@end
